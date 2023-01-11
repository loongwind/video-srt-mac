import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/repository/shell_repository.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

import 'custom_dialog_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedFilePath;
  String cmdRecord = "";
  bool running = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('首页'),
            actions: [
              ToolBarIconButton(
                label: 'Toggle Sidebar',
                icon: const MacosIcon(CupertinoIcons.sidebar_left),
                showLabel: false,
                tooltipMessage: 'Toggle Sidebar',
                onPressed: () {
                  MacosWindowScope.of(context).toggleSidebar();
                },
              )
            ],
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      buildSelectFile(),
                      buildCmdRecord(),
                      Container(
                        height: 40,
                      ),
                      buildCommitButton()
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildSelectFile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "视频文件:",
          style: TextStyle(fontSize: 13),
        ),
        Container(
          width: 3,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Text(
            selectedFilePath ?? "请选择视频文件",
            style: TextStyle(
                color:
                    selectedFilePath == null ? Colors.grey : Colors.black87,
                fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          width: 3,
        ),
        MacosIconButton(
          icon: const Icon(
            Icons.more_horiz,
            size: 16,
          ),
          backgroundColor: Colors.grey[200],
          onPressed: () async {
            var path = await PathUtils.selectFile();
            if (path != null) {
              setState(() {
                selectedFilePath = path;
              });
            }
          },
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        )
      ],
    );
  }

  Widget buildCommitButton() {
    return PushButton(
      buttonSize: ButtonSize.large,
      padding: EdgeInsets.symmetric(horizontal: running ? 10 : 25, vertical: 5),
      onPressed: running ? null :() async{
        var path = selectedFilePath;
        if(path == null){
          showSelectFileHintDialog();
          return;
        }
        setState(() {
          running = true;
          cmdRecord = "开始提取，请稍后。。。\n";
        });
        await ShellRepository.runVideoSrt(path, (event) {
          setState(() {
            cmdRecord += "$event\n";
          });
          if(event.contains("完成")){
            showFinishHintDialog();
          }
        });
        setState(() {
          running = false;
        });
      },
      child: running ? Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Transform.scale(scale: 0.8, child: ProgressCircle()),
          SizedBox(width: 5,),
          const Text("提取中...")
        ],),
      ) : const Text("提取"),
    );
  }

  Widget buildCmdRecord(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],

      ),
      width: 500,
      constraints: BoxConstraints(
        minHeight: 200,
      ),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(cmdRecord),
    );
  }

  void showSelectFileHintDialog(){
    showMacosAlertDialog(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.only(left: 200.0),
        child: CustomMacosAlertDialog(
          primaryButton:PushButton(
            buttonSize: ButtonSize.large,
            child: Text('确定'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(
                '提示',
                style: MacosTheme.of(context).typography.title2,
              ),
              SizedBox(height: 10,),
              Text(
                '请先选择视频文件',
                textAlign: TextAlign.center,
                style: MacosTheme.of(context).typography.headline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFinishHintDialog(){
    showMacosAlertDialog(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.only(left: 200.0),
        child: CustomMacosAlertDialog(
          primaryButton:PushButton(
            buttonSize: ButtonSize.large,
            child: Text('打开文件夹'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          secondaryButton: PushButton(
            isSecondary: true,
            buttonSize: ButtonSize.large,
            child: Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(
                '提示',
                style: MacosTheme.of(context).typography.title2,
              ),
              SizedBox(height: 10,),
              Text(
                '恭喜你，提取完成',
                textAlign: TextAlign.center,
                style: MacosTheme.of(context).typography.headline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
