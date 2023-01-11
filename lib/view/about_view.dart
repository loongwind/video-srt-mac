import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:process_run/shell.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_srt_macos/repository/shell_repository.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

import 'custom_dialog_view.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final githubUrl = "https://github.com/loongwind/video-srt-mac";
  String appName = "";
  String version = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('关于'),
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
                      DefaultTextStyle(style: MacosTheme.of(context).typography.title1, child: Text(appName)),
                      const SizedBox(height: 10,),
                      DefaultTextStyle(style: MacosTheme.of(context).typography.title2, child: Text("版本：$version")),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTextStyle(style: MacosTheme.of(context).typography.body, child: const Text("@loongwind")),
                          const SizedBox(width: 10,),
                          GestureDetector(child: DefaultTextStyle(style: MacosTheme.of(context).typography.body.copyWith(color: Colors.blueAccent, decoration: TextDecoration.underline,), child: Text("Github")),
                            onTap: (){
                              Uri url = Uri.parse(githubUrl);
                              launchUrl(url);
                            },),
                        ],
                      )

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
