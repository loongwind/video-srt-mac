
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:video_srt_macos/constanst.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

class ZipRepository{

  static Future<void> unzip(String zipFile, String targetDir) async{
    var goFile = Directory(targetDir);
    if(await goFile.exists()){
      return;
    }
    final inputStream = InputFileStream(zipFile);
    final archive = ZipDecoder().decodeBuffer(inputStream);
    extractArchiveToDisk(archive, targetDir);
    return;
  }


  static Future<void> unzipGo() async{
    var workDirPath = await PathUtils.getWorkDirPath();
    unzip(GO_ZIP_PATH, "$workDirPath/$GO");
    return;
  }

  static Future<void> unzipVideoSrt() async{
    var workDirPath = await PathUtils.getWorkDirPath();
    unzip(VIDEO_SRT_ZIP_PATH, "$workDirPath/$VIDEO_SRT");
    return;
  }
}