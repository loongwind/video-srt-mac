

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../constanst.dart';

class PathUtils{
  static Future<String> getWorkDirPath() async{
    Directory tempDir = await getLibraryDirectory();
    var workDir = "${tempDir.path}/$WORK_DIR_NAME";
    var dir = Directory(workDir);
    if(! (await dir.exists())){
      await dir.create();
    }
    return workDir;
  }

  static Future<String?> selectFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var path = result?.files.single.path;
    print(result?.files.single.path);
    if (path != null) {
      path = path.substring(path.indexOf("/", 9), path.length);
      print(path);
      return path;
    }
    return null;
  }
}