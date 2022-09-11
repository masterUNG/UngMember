// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungmenber/utility/my_constant.dart';
import 'package:ungmenber/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  final double? size;
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: size,
      child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: MyConstant.primary),
          onPressed: pressFunc,
          child: WidgetText(
            text: label,
            textStyle: MyConstant().h3ButtonStyle(),
          )),
    );
  }
}
