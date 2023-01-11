
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/view/InputLine.dart';

class ConfigVoiceView extends StatefulWidget {
  const ConfigVoiceView({super.key});

  @override
  State<ConfigVoiceView> createState() => _ConfigVoiceViewState();
}

class _ConfigVoiceViewState extends State<ConfigVoiceView> {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[100]
          ),
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              InputLine("AppKey"),
              InputLine("AccessKeyId"),
              InputLine("AccessKeySecret"),
              const SizedBox(height: 30,),
              buildSaveButton(),
            ],
          ),
        );
      },
    );
  }

  Widget buildSaveButton() {
    return PushButton(
      buttonSize: ButtonSize.large,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      onPressed: () {

      },
      child: const Text("保存"),
    );
  }



}
