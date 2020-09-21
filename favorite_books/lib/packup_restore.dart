import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class BackupRestore {
  static Future<void> backup(Map<dynamic, String> map) async {
    String json = jsonEncode(map);
    Directory dir = await _getDirectory();
    String formattedDate = DateTime.now().toString().replaceAll('.', '-').replaceAll(' ', '-').replaceAll(':', '-');
    File backupFile = File('${dir.path}$formattedDate.hivebackup');
    await backupFile.writeAsString(json);
  }

  static Future<Map<int, String>> restore() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.any);
    if (res.count == 0) return null;

    final file = File(res.files.first.path);
    Map<dynamic, dynamic> map = jsonDecode(await file.readAsString()) as Map<dynamic, dynamic>;
    return map.map<int, String>((key, value) => MapEntry(int.parse(key), value));
  }

  static Future<Directory> _getDirectory() async {
    Directory directory = await getExternalStorageDirectory();
    const String pathExt = '/backups/';
    Directory newDirectory = Directory(directory.path + pathExt);
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }
}
