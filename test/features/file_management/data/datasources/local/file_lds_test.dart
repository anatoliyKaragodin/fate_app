// import 'package:flutter_test/flutter_test.dart';
// import 'package:fate_app/features/file_management/data/datasources/local/file_LDS_impl.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

// void main() {
//     TestWidgetsFlutterBinding.ensureInitialized(); // Инициализация привязки

//   group('FileLdsImpl', () {
//     late FileLdsImpl fileLdsImpl;
//     // late Directory tempDir;

//     setUp(() async {
//       fileLdsImpl = FileLdsImpl();
//       // tempDir = await getTemporaryDirectory();
//     });

//     test('should save and delete file successfully', () async {
//       final fileName = 'test_file.txt';
//       // final filePath = '${tempDir.path}/$fileName';
//       final mockFile = PlatformFile(name: fileName, size: 10);

//       // Сохранение файла
//       final filePath=await fileLdsImpl.save(mockFile);
//       expect(await File(filePath!).exists(), isTrue);

//       // Удаление файла
//       await fileLdsImpl.delete(filePath);
//       expect(await File(filePath).exists(), isFalse);
//     });
//   });
// }

void main() {}
