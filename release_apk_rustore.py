import base64
import datetime
import json
import os
import requests
import sys
import re
from pathlib import Path
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA512

def load_env(dotenv_path: Path) -> None:
    """
    Гарантированно загружает `KEY=VALUE` из файла .env.
    Нужно для GitHub Actions, где текущая директория и наличие "старого" .env
    могут отличаться; при этом секреты должны иметь приоритет.
    """
    if not dotenv_path.exists():
        return

    # Читаем как текст с заменой проблемных символов, чтобы не падать.
    content = dotenv_path.read_text(encoding="utf-8", errors="replace")
    for raw_line in content.splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.strip()
        value = value.strip()
        if not key:
            continue

        # Убираем обрамляющие кавычки, если они есть.
        if (value.startswith('"') and value.endswith('"')) or (value.startswith("'") and value.endswith("'")):
            value = value[1:-1]

        # Важно: если ключ встречается несколько раз, последнее значение имеет приоритет.
        os.environ[key] = value

def generate_signature(key_id, private_key_content):
    # Декодируем и загружаем приватный ключ
    private_key = RSA.import_key(base64.b64decode(private_key_content))

    # Создаем временную метку
    timestamp = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec='milliseconds')
    # Формируем сообщение для подписи
    message_to_sign = key_id + timestamp

    # Подписываем сообщение
    hash_obj = SHA512.new(message_to_sign.encode())
    signer = pkcs1_15.new(private_key)
    signature_bytes = signer.sign(hash_obj)
    signature_value = base64.b64encode(signature_bytes).decode()

    return key_id, timestamp, signature_value

def authenticate_rustore(key_id, timestamp, signature):
    url = 'https://public-api.rustore.ru/public/auth'
    headers = {
        'Content-Type': 'application/json'
    }
    data = {
        "keyId": key_id,
        "timestamp": timestamp,
        "signature": signature
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))

    if response.status_code == 200:
        print("Request successful.")
        return response.json().get('body', {}).get('jwe')
    else:
        print("Request failed with status code:", response.status_code)
        return None

def create_version_draft(package_name, public_token, whatsNew):
    url = f'https://public-api.rustore.ru/public/v1/application/{package_name}/version'
    headers = {
        'Content-Type': 'application/json',
        'Public-Token': public_token
    }
    data = {
        "appType": "MAIN",
        "whatsNew": whatsNew,
        "publishType": "MANUAL"
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))

    if response.status_code == 200:
        print("Version draft created successfully.")
        return response.json()
    elif response.status_code == 400 and 'You already have draft version' in response.json().get('message', ''):
        # Используем регулярное выражение для извлечения ID черновика из сообщения
        message = response.json().get('message', '')
        match = re.search(r'ID = (\d+)', message)
        version_id = match.group(1) if match else None

        if version_id:
            print(f"Draft version already exists with ID = {version_id}, attempting to delete...")
            delete_version_draft(package_name, version_id, public_token)
            return create_version_draft(package_name, public_token, whatsNew)  # Повторная попытка создания
        else:
            print("Failed to extract draft version ID from the message.")
            return None
    else:
        print(f"Failed to create version draft. Status code: {response.status_code}")
        return None


def delete_version_draft(package_name, version_id, public_token):
    url = f'https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_id}'
    headers = {
        'Content-Type': 'application/json',
        'Public-Token': public_token
    }

    response = requests.delete(url, headers=headers)

    return response.status_code


def upload_apk(package_name, version_id, public_token, apk_file_path, is_main_apk=True):
    url = f"https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_id}/apk"
    params = {
        "isMainApk": str(is_main_apk).lower(),  # Значение должно быть в формате 'true' или 'false'
    }
    headers = {
        'Public-Token': public_token
    }

    print("Starting upload APK to Rustore")
    print(f"POST {url}")
    print(f"APK path: {apk_file_path}")

    with open(apk_file_path, "rb") as f:
        files = {"file": f}
        response = requests.post(url, headers=headers, params=params, files=files)

    if response.status_code == 200:
        print("APK file uploaded successfully.")
        return response.status_code
    else:
        print("Failed to upload APK file.")
        print("Status code:", response.status_code)
        # Тело ответа часто содержит причину (например, валидация draft/version id).
        try:
            print("Response JSON:", response.json())
        except Exception:
            print("Response text:", response.text)
        return None

def submit_draft_for_moderation(package_name, version_id, public_token, priority_update=0):
    url = f'https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_id}/commit'
    params = {
        'priorityUpdate': priority_update
    }
    headers = {
        'Public-Token': public_token,
        'Content-Type': 'application/json'
    }

    response = requests.post(url, headers=headers, params=params)

    if response.status_code == 200:
        print("Draft version submitted for moderation successfully.")
        return response.status_code
    else:
        print(f"Failed to submit draft version for moderation. Status code: {response.status_code}")
        return None

def main():

    if len(sys.argv) < 2:
        print("Не передан аргумент whatsNew.")
        return
    whatsNew = sys.argv[1]

    # Загружаем переменные окружения из .env файла рядом со скриптом.
    # Нам важно не зависеть от текущей рабочей директории и не использовать python-dotenv.
    dotenv_path = (Path(__file__).resolve().parent / ".env")
    load_env(dotenv_path)

    # Получаем переменные окружения
    key_id = os.getenv('RUSTORE_KEY_ID')
    private_key_content = os.getenv('RUSTORE_PRIVATE_KEY')

    package_name = 'com.fate_char'

    if key_id is None or private_key_content is None:
        print("Отсутствуют переменные окружения RUSTORE_KEY_ID или RUSTORE_PRIVATE_KEY")

    else:
        # Генерируем подпись
        key_id, timestamp, signature = generate_signature(key_id, private_key_content)
        # Аутентификация в RuStore
        public_token = authenticate_rustore(key_id, timestamp, signature)

        if public_token:
            # Создание черновика версии
            version_response = create_version_draft(package_name, public_token, whatsNew)
            if version_response:
                body = version_response.get("body")
                version_id = None
                if isinstance(body, dict):
                    # У разных версий API поле может называться по-разному.
                    version_id = body.get("id") or body.get("versionId") or body.get("version_id")
                else:
                    version_id = body

                print("Create version draft response body:", body)
                print(f"Resolved version_id: {version_id} ({type(version_id).__name__})")

                if version_id:
                    apk_path = str(Path(__file__).resolve().parent / "build/app/outputs/flutter-apk/app-release.apk")
                    upload_apk_status_code = upload_apk(
                        package_name,
                        version_id,
                        public_token,
                        apk_path,
                    )
                    if upload_apk_status_code == 200:
                        submit_draft_for_moderation(package_name, version_id, public_token)

if __name__ == "__main__":
    main()
