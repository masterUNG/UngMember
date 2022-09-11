import 'package:flutter/material.dart';

class WidgetWhiteBG extends StatelessWidget {
  const WidgetWhiteBG({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        return Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: boxConstraints.maxHeight*0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
