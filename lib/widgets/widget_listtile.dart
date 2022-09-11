// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungmenber/utility/my_constant.dart';
import 'package:ungmenber/widgets/widget_text.dart';

class WidgetListtile extends StatelessWidget {
  final Widget widget;
  final String title;
  final String subTitle;
  const WidgetListtile({
    Key? key,
    required this.widget,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget,
      title: WidgetText(
        text: title,
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: WidgetText(text: subTitle),
    );
  }
}
