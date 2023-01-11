
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/view/InputLine.dart';

import '../model/ini_model.dart';
import '../repository/ini_repository.dart';

class ConfigVoiceView extends StatefulWidget {
  const ConfigVoiceView({super.key});

  @override
  State<ConfigVoiceView> createState() => _ConfigVoiceViewState();
}

class _ConfigVoiceViewState extends State<ConfigVoiceView> {
  TextEditingController appKeyDomainController = TextEditingController();
  TextEditingController accessKeyIdController = TextEditingController();
  TextEditingController accessKeySecretController = TextEditingController();
  IniModel? iniModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async{
    var iniModel = await IniRepository.readIniData();
    appKeyDomainController.text = iniModel.voice_appKey ?? "";
    accessKeyIdController.text = iniModel.voice_accessKeyId?? "";
    accessKeySecretController.text = iniModel.voice_accessKeySecret ?? "";
  }

  void save() async{
    var model = iniModel;
    if(model != null){
      model.voice_appKey = appKeyDomainController.text;
      model.voice_accessKeyId = accessKeyIdController.text;
      model.voice_accessKeySecret = accessKeySecretController.text;
      IniRepository.writeIniData(model);
    }
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
              Text("阿里云语音识别配置"),
              SizedBox(height: 10,),
              InputLine("AppKey", appKeyDomainController),
              InputLine("AccessKeyId", accessKeyIdController),
              InputLine("AccessKeySecret", accessKeySecretController),
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
