// import 'package:dio/dio.dart';
//
// Future<void> appToRustore() async {
//   final dio = Dio();
//
//   try {
//     final response = await dio.post(
//       'https://public-api.rustore.ru/public/v1/application/com.package.com/version',
//       data: {
//         "appName": "Приложение для RuStore",
//         "appType": "MAIN",
//         "categories": ["news", "education"],
//         "ageLegal": "7+",
//         "shortDescription": "Приложение для RuStore",
//         "fullDescription": "fullDescription - Приложение для RuStore",
//         "whatsNew": "whatsNew - Приложение для RuStore",
//         "moderInfo": "moderInfo - Приложение для RuStore",
//         "priceValue": 1100,
//       },
//       options: Options(
//         headers: {
//           'Content-Type': 'application/json',
//           'Public-Token': 'YOUR_TOKEN',
//         },
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       print('Данные успешно отправлены: ${response.data}');
//
//       _uploadApk(apiToken, appId, versionId, apkPath);
//     } else {
//       print('Ошибка при отправке данных: ${response.statusCode} - ${response.statusMessage}');
//     }
//   } catch (e) {
//     print('Произошла ошибка: $e');
//   }
// }
//
// Future<void> _uploadApk(
//     String apiToken,
//     String appId,
//     String versionId,
//     String apkPath,
//     ) async {
//   final dio = Dio();
//
//   try {
//     FormData formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(apkPath),
//     });
//
//     final response = await dio.post(
//       'https://public-api.rustore.ru/public/v1/application/$appId/version/$versionId/apk?servicesType=Unknown&isMainApk=true',
//       data: formData,
//       options: Options(
//         headers: {
//           'Public-Token': apiToken,
//         },
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       print('APK загружен успешно: ${response.data}');
//
//       _commitUpdate(apiToken, packageName, versionId, priorityUpdate);
//     } else {
//       print('Ошибка при загрузке APK: ${response.statusCode} - ${response.statusMessage}');
//     }
//   } catch (e) {
//     print('Произошла ошибка: $e');
//   }
// }
//
// Future<void> _commitUpdate(
//     String apiToken,
//     String packageName,
//     String versionId,
//     bool priorityUpdate,
//     ) async {
//   final dio = Dio();
//
//   try {
//     final response = await dio.post(
//       'https://public-api.rustore.ru/public/v1/application/$packageName/version/$versionId/commit?priorityUpdate=$priorityUpdate',
//       options: Options(
//         headers: {
//           'Public-Token': apiToken,
//         },
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       print('Обновление подтверждено: ${response.data}');
//     } else {
//       print('Ошибка при подтверждении обновления: ${response.statusCode} - ${response.statusMessage}');
//     }
//   } catch (e) {
//     print('Произошла ошибка: $e');
//   }
// }
