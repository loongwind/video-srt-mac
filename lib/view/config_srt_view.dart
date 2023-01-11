
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/view/InputLine.dart';

class ConfigSrtView extends StatefulWidget {
  const ConfigSrtView({super.key});

  @override
  State<ConfigSrtView> createState() => _ConfigSrtViewState();
}

class _ConfigSrtViewState extends State<ConfigSrtView> {
  var selected = true;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              buildInputItem("智能分段"),
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

  Widget buildInputItem(String title){
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 130,
              child: Text("$title：", textAlign: TextAlign.end,)),
          SizedBox(
              width: 300,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Transform.scale(
                  scale: 0.8,
                  child: MacosSwitch(value: selected, onChanged: (selected){
                    setState(() {
                      this.selected = selected;
                    });
                  }),
                ),
              ),),
        ],
      ),
    );
  }



}
