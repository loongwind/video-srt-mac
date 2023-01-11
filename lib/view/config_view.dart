import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/repository/shell_repository.dart';
import 'package:video_srt_macos/utils/path_utils.dart';

import 'config_oss_view.dart';
import 'config_srt_view.dart';
import 'config_voice_view.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  MacosTabController controller = MacosTabController(length: 3);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('配置'),
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
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: MacosTabView(
                      controller: controller,
                      tabs: [
                        MacosTab(
                          label: '对象存储配置',
                        ),
                        MacosTab(
                          label: '语音识别配置',
                        ),
                        MacosTab(
                          label: '字幕配置',
                        ),
                      ],
                      children: [
                        ConfigOSSView(),
                        ConfigVoiceView(),
                        ConfigSrtView(),
                      ]),
                );
              },
            ),
          ],
        );
      },
    );
  }


}
