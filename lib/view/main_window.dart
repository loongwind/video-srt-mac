import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/repository/zip_repository.dart';
import 'package:video_srt_macos/view/config_view.dart';
import 'package:video_srt_macos/view/help_view.dart';

import 'home_view.dart';


class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _pageIndex = 0;
  bool inited = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async{
    await ZipRepository.unzipGo();
    await ZipRepository.unzipVideoSrt();
    setState(() {
      inited = true;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: 'VideoSrtMacos',
          menus: [
            PlatformMenuItem(
              label: '关于',
              onSelected: () async {
                final window = await DesktopMultiWindow.createWindow(jsonEncode(
                  {
                    'args1': 'About video_srt_macos',
                    'args2': 500,
                    'args3': true,
                  },
                ));
                debugPrint('$window');
                window
                  ..setFrame(const Offset(0, 0) & const Size(350, 350))
                  ..center()
                  ..setTitle('About video_srt_macos')
                  ..show();
              },
            ),
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.quit,
            ),
          ],
        ),
      ],
      child: inited ? MacosWindow(
        sidebar: Sidebar(
          minWidth: 200,
          builder: (context, scrollController) => SidebarItems(
            currentIndex: _pageIndex,
            onChanged: (index) {
              setState(() => _pageIndex = index);
            },
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                label: Text('首页'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.settings),
                label: Text('配置'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.helm),
                label: Text('帮助'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.info),
                label: Text('关于'),
              ),
            ],
          ),
        ),
        child: IndexedStack(
          index: _pageIndex,
          children: const [
            HomePage(),
            ConfigView(),
            HelpView()
          ],
        ),
      ) : Container(
        color: Colors.grey[100],
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProgressCircle(
            value: null,
          ),
          Text("正在初始化，第一次初始化会比较慢，请稍后 ..."),
        ],
      ),
      ),
    );
  }
}