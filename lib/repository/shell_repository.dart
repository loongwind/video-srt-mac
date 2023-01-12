
import 'dart:io';
import 'dart:ui';

import 'package:process_run/shell.dart';
import 'package:video_srt_macos/constanst.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

import 'ini_repository.dart';

class ShellRepository{
  static Future<void> runVideoSrt(String targetFilePath, Function(String) callback) async{
    if(targetFilePath.isEmpty){
      return;
    }
    var workDir = await PathUtils.getWorkDirPath();
    var controller = ShellLinesController();
    var shell = Shell(stdout: controller.sink, verbose: false);

    var go = "../go/bin/go";
    if(!BUILTIN_GO_ENV){
      var iniModel = await IniRepository.readIniData();
      go = iniModel.go_path ?? go;
    }

    shell = shell.pushd("$workDir/$VIDEO_SRT");
    // shell.run("export PATH=\$PATH:./");
    // shell.run("export GOROOT=${tempDir.path}/go");
    print("-------切换vide-str目录-----");
    try {
      if(BUILTIN_GO_ENV){
        await shell.run("chmod -R +x $workDir/$GO");
      }
      shell.run("chmod +x ffmpeg");
    } on ShellException catch (_) {
      // We might get a shell exception
    }
    print("-------脚本权限配置完成-----");
    // shell.run('export GO111MODULE="on"');
    controller.stream.listen((event) {
      callback(event);
    });
    // await shell.run("/usr/local/go/bin/go run main.go /Users/chengminghui/Downloads/ardf-recyclerview.mp4");
    print("-------执行命令-----");
    try {
      await shell.run("$go run main.go $targetFilePath");
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