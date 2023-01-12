
import 'dart:io';

import 'package:process_run/shell.dart';
import 'package:video_srt_macos/constanst.dart';
import 'package:video_srt_macos/utils/path_utils.dart';


class ShellRepository{
  static Future<void> runVideoSrt(String targetFilePath, Function(String) callback) async{
    if(targetFilePath.isEmpty){
      return;
    }
    var workDir = await PathUtils.getWorkDirPath();
    var controller = ShellLinesController();
    var shell = Shell(stdout: controller.sink, verbose: false);

    shell = shell.pushd("$workDir/$VIDEO_SRT");
    print("-------切换vide-str目录-----");
    try {
      await shell.run("chmod +x ffmpeg");
      await shell.run("chmod +x video-srt");
    } on ShellException catch (_) {
      // We might get a shell exception
    }
    print("-------脚本权限配置完成-----");
    // shell.run('export GO111MODULE="on"');
    controller.stream.listen((event) {
      callback(event);
    });
    print("-------执行命令-----");
    try {
      await shell.run("./video-srt $targetFilePath");
    } on ShellException catch (_) {
      // We might get a shell exception
    }
    print("-------执行完成-----");
    shell = shell.popd();
    return;
  }

  static void openFileDir(String filePath){
    File file = File(filePath);
    final String dirPath = file.parent.absolute.path;
    var shell = Shell();
    shell.run("open $dirPath");
  }

  static void cmd(String cmd){
    var shell = Shell();
    shell.run(cmd);
  }
}