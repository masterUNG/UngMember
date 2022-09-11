// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungmenber/widgets/widget_image.dart';
import 'package:ungmenber/widgets/widget_listtile.dart';
import 'package:ungmenber/widgets/widget_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    String? label,
    Function()? pressFunc,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: WidgetListtile(
              widget: const SizedBox(
                width: 80,
                child: WidgetImage(),
              ),
              title: title,
              subTitle: subTitle),
          actions: [
            label == null
                ? const SizedBox()
                : WidgetTextButton(label: label, pressFunc: pressFunc!),
            WidgetTextButton(
              label: label == null ? 'OK' : 'Cancel',
              pressFunc: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
