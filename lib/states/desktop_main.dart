import 'package:flutter/material.dart';
import 'package:ungmenber/utility/my_constant.dart';
import 'package:ungmenber/widgets/widget_text.dart';

class DeskTopMain extends StatelessWidget {
  const DeskTopMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: WidgetText(text: 'Desktop', textStyle: MyConstant().h1Style(),)),
    );
  }
}