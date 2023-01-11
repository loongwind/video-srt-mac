import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:process_run/shell.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_srt_macos/repository/shell_repository.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

import 'custom_dialog_view.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final githubUrl = "https://github.com/loongwind/video-srt-mac";

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('帮助'),
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      DefaultTextStyle(style: MacosTheme.of(context).typography.title2, child: Text("点击以下链接")),
                      SizedBox(height: 10,),
                      GestureDetector(child: DefaultTextStyle(style: MacosTheme.of(context).typography.title2.copyWith(color: Colors.blueAccent, decoration: TextDecoration.underline,), child: Text(githubUrl)),
                      onTap: (){
                        Uri url = Uri.parse(githubUrl);
                        launchUrl(url);
                      },),
                      SizedBox(height: 10,),
                      DefaultTextStyle(style: MacosTheme.of(context).typography.title2, child: Text("查看更多帮助"))
                    ]
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

}
