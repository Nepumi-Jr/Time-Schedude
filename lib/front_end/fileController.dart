import 'dart:convert';
import 'dart:io';

void createFile(Map<String, dynamic> content, Directory dir, String fileName,
    bool fileExists) {
  print("Creating file!");
  File file = new File(dir.path + "/" + fileName);
  print(dir.path + "/" + fileName);
  file.createSync();
  fileExists = true;
  file.writeAsStringSync(json.encode(content));
}

void writeToFile(String key, dynamic value, Directory dir, bool fileExists,
    String fileName, File jsonFile) {
  print("Writing to file!");
  Map<String, dynamic> content = {key: value};
  if (fileExists) {
    print("File exists");
    print(dir.path + "/" + fileName);
    Map<String, dynamic> jsonFileContent =
        json.decode(jsonFile.readAsStringSync());
    jsonFileContent.addAll(content);
    jsonFile.writeAsStringSync(json.encode(jsonFileContent));
  } else {
    print("File does not exist!");
    createFile(content, dir, fileName, fileExists);
  }
}
