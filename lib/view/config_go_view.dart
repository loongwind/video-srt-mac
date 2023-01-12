
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/view/InputLine.dart';

import '../model/ini_model.dart';
import '../repository/ini_repository.dart';

class ConfigGOView extends StatefulWidget {
  const ConfigGOView({super.key});

  @override
  State<ConfigGOView> createState() => _ConfigGOViewState();
}

class _ConfigGOViewState extends State<ConfigGOView> {
  TextEditingController goPathController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async{
    var iniModel = await IniRepository.readIniData();
    goPathController.text = iniModel.go_path ?? "";
  }

  void save() async{
    var model = await IniRepository.readIniData();
    model.go_path = goPathController.text;
    IniRepository.writeIniData(model);
  }
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
              Text("GO路径配置"),
              SizedBox(height: 10,),
              InputLine("GO路径", goPathController),
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
      onPressed: save,
      child: const Text("保存"),
    );
  }



}
