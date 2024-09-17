import base64
import datetime
import json
import os
import requests
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA512
from dotenv import load_dotenv

def generate_signature(key_id, private_key_content):
    # Декодируем и загружаем приватный ключ
    private_key = RSA.import_key(base64.b64decode(private_key_content))

    # Создаем временную метку
    timestamp = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec='milliseconds')
    # Формируем сообщение для подписи
    message_to_sign = key_id + timestamp
    print("Message to sign:", message_to_sign)

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
        print("Response:", response.json())
    else:
        print("Request failed with status code:", response.status_code)
        print("Response:", response.text)

def main():
    # Загружаем переменные окружения из .env файла
    load_dotenv()

    # Получаем переменные окружения
    key_id = os.getenv('RUSTORE_KEY_ID')
    private_key_content = os.getenv('RUSTORE_PRIVATE_KEY')

    print("Private Key Content:", private_key_content[:100] + "...")

    if key_id is None or private_key_content is None:
        print("Отсутствуют переменные окружения RUSTORE_KEY_ID или RUSTORE_PRIVATE_KEY")
    else:
        # Генерируем подпись
        key_id, timestamp, signature = generate_signature(key_id, private_key_content)
        # Отправляем запрос
        authenticate_rustore(key_id, timestamp, signature)

if __name__ == "__main__":
    main()
