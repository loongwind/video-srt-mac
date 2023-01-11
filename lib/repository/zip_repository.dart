
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:video_srt_macos/constanst.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

class ZipRepository{

  static Future<void> unzip(String zipFile, String targetDir) async{
    final inputStream = InputFileStream(zipFile);
    final archive = ZipDecoder().decodeBuffer(inputStream);
    extractArchiveToDisk(archive, targetDir);
    return;
  }


  static Future<void> unzipGo() async{
    var workDirPath = await PathUtils.getWorkDirPath();
    var goFile = Directory("$workDirPath/$GO");
    if(await goFile.exists()){
      return;
    }
    await unzip(GO_ZIP_PATH, "$workDirPath");
    return;
  }

  static Future<void> unzipVideoSrt() async{
    var workDirPath = await PathUtils.getWorkDirPath();
    var videoSrtFile = Directory("$workDirPath/$VIDEO_SRT");
    if(await videoSrtFile.exists()){
      return;
    }
    await unzip(VIDEO_SRT_ZIP_PATH, "$workDirPath");
    return;
  }
}