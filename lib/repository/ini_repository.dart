
import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ini/ini.dart';
import 'package:video_srt_macos/constanst.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

import '../model/ini_model.dart';

class IniRepository{


  static Future<IniModel> readIniData() async{
    var workDir = await PathUtils.getWorkDirPath();
    var iniPath = "$workDir/$VIDEO_SRT/$CONFIG_NAME";
    Completer<IniModel> completer = Completer();
    File(iniPath).readAsLines()
        .then((lines) => Config.fromStrings(lines))
        .then((Config config){
          var iniModel = IniModel();
          iniModel.intelligent_block = (config.get("srt", "intelligent_block") ?? "true").toLowerCase() == "true";
          iniModel.oss_endpoint = config.get("aliyunOss", "endpoint");
          iniModel.oss_bucketName = config.get("aliyunOss", "bucketName") ;
          iniModel.oss_bucketDomain = config.get("aliyunOss", "bucketDomain") ;
          iniModel.oss_accessKeyId = config.get("aliyunOss", "accessKeyId") ;
          iniModel.oss_accessKeySecret = config.get("aliyunOss", "accessKeySecret") ;
          iniModel.voice_appKey = config.get("aliyunClound", "appKey") ;
          iniModel.voice_accessKeyId = config.get("aliyunClound", "accessKeyId") ;
          iniModel.voice_accessKeySecret = config.get("aliyunClound", "accessKeySecret") ;
          iniModel.go_path = config.get("go", "goPath") ;
          completer.complete(iniModel);
    });
    return completer.future;
  }

  static Future<void> writeIniData(IniModel iniModel) async{
    Config config = Config();
    config.addSection("srt");
    config.set("srt", "intelligent_block", iniModel.intelligent_block.toString());

    config.addSection("aliyunOss");
    config.set("aliyunOss", "endpoint", iniModel.oss_endpoint ?? "");
    config.set("aliyunOss", "bucketName", iniModel.oss_bucketName ?? "");
    config.set("aliyunOss", "bucketDomain", iniModel.oss_bucketDomain ?? "");
    config.set("aliyunOss", "accessKeyId", iniModel.oss_accessKeyId ?? "");
    config.set("aliyunOss", "accessKeySecret", iniModel.oss_accessKeySecret ?? "");

    config.addSection("aliyunClound");
    config.set("aliyunClound", "appKey", iniModel.voice_appKey ?? "");
    config.set("aliyunClound", "accessKeyId", iniModel.voice_accessKeyId ?? "");
    config.set("aliyunClound", "accessKeySecret", iniModel.voice_accessKeySecret ?? "");

    config.addSection("go");
    config.set("go", "goPath", iniModel.go_path ?? "");

    var workDir = await PathUtils.getWorkDirPath();
    var iniPath = "$workDir/$VIDEO_SRT/$CONFIG_NAME";
    await File(iniPath).writeAsString(config.toString());
    return;
  }

}