/*
  TODO : @Ford ฝากไปเทสการอ่านไฟล์เขียนไฟล์ด้วย !!!!
*/
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> getFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  static Future<String> readFile(String fileName) async {
    try {
      final file = await getFile(fileName);

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return 'error';
    }
  }

  static Future<File> writeFile(String fileName, String subject) async {
    final file = await getFile(fileName);

    // Write the file
    return file.writeAsString(subject);
  }
}
