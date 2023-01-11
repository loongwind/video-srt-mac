
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:video_srt_macos/model/ini_model.dart';
import 'package:video_srt_macos/view/InputLine.dart';

import '../repository/ini_repository.dart';

class ConfigOSSView extends StatefulWidget {
  const ConfigOSSView({super.key});

  @override
  State<ConfigOSSView> createState() => _ConfigOSSViewState();
}

class _ConfigOSSViewState extends State<ConfigOSSView> {
  TextEditingController endpointController = TextEditingController();
  TextEditingController bucketNameController = TextEditingController();
  TextEditingController bucketDomainController = TextEditingController();
  TextEditingController accessKeyIdController = TextEditingController();
  TextEditingController accessKeySecretController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async{
    var iniModel = await IniRepository.readIniData();
    endpointController.text = iniModel.oss_endpoint ?? "";
    bucketNameController.text = iniModel.oss_bucketName ?? "";
    bucketDomainController.text = iniModel.oss_bucketDomain ?? "";
    accessKeyIdController.text = iniModel.oss_accessKeyId ?? "";
    accessKeySecretController.text = iniModel.oss_accessKeySecret ?? "";
  }

  void save() async{
    var model = await IniRepository.readIniData();
    model.oss_endpoint = endpointController.text;
    model.oss_bucketName = bucketNameController.text;
    model.oss_bucketDomain = bucketDomainController.text;
    model.oss_accessKeyId = accessKeyIdController.text;
    model.oss_accessKeySecret = accessKeySecretController.text;
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
              Text("阿里云OSS配置"),
              SizedBox(height: 10,),
              InputLine("Endpoint", endpointController),
              InputLine("BucketName", bucketNameController),
              InputLine("BucketDomain", bucketDomainController),
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
