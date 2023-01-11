import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class InputLine extends StatelessWidget {
  String title;
  InputLine(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return buildInputItem(title);
  }

  Widget buildInputItem(String title){
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 130,
              child: Text("$title：", textAlign: TextAlign.end,)),
          SizedBox(
              width: 300,
              child: MacosTextField(placeholder: "请输入$title",)),
        ],
      ),
    );
  }
}
