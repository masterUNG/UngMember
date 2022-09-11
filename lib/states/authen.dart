import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmenber/models/user_model.dart';
import 'package:ungmenber/states/create_account.dart';
import 'package:ungmenber/utility/my_constant.dart';
import 'package:ungmenber/utility/my_dialog.dart';
import 'package:ungmenber/widgets/widget_button.dart';
import 'package:ungmenber/widgets/widget_form.dart';
import 'package:ungmenber/widgets/widget_image.dart';
import 'package:ungmenber/widgets/widget_text.dart';
import 'package:ungmenber/widgets/widget_text_button.dart';
import 'package:ungmenber/widgets/widget_whitebg.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusScopeNode());
          },
          child: Container(
            decoration: MyConstant().primaryBox(),
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight,
            child: Stack(
              children: [
                contentTop(boxConstraints),
                const WidgetWhiteBG(),
                contentMid(boxConstraints),
                contentBotton(context: context),
              ],
            ),
          ),
        );
      }),
    );
  }

  Column contentBotton({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetTextButton(
              label: 'Create New Account',
              pressFunc: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const CreateAccount();
                  },
                ));
              },
            ),
          ],
        ),
      ],
    );
  }

  Row contentMid(BoxConstraints boxConstraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: boxConstraints.maxWidth * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                text: 'Login:',
                textStyle: MyConstant().h2Style(),
              ),
              WidgetForm(
                changeFunc: (p0) {
                  user = p0.trim();
                },
                hint: 'User:',
                iconData: Icons.person_outline,
              ),
              WidgetForm(
                changeFunc: (p0) {
                  password = p0.trim();
                },
                obsecu: true,
                hint: 'Password:',
                iconData: Icons.lock_outline,
              ),
              WidgetButton(
                size: boxConstraints.maxWidth * 0.6,
                label: 'Login',
                pressFunc: () {
                  if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                    MyDialog(context: context).normalDialog(
                        title: 'มีช่องว่าง ?',
                        subTitle: 'กรุณากรอก ให้ครบทุกช่อง คะ');
                  } else {
                    processCheckAuthen();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Row contentTop(BoxConstraints boxConstraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 36),
          width: boxConstraints.maxWidth * 0.7,
          child: Row(
            children: [
              newImage(),
              newAppName(),
            ],
          ),
        ),
      ],
    );
  }

  WidgetText newAppName() => WidgetText(
        text: MyConstant.appName,
        textStyle: MyConstant().h1Style(),
      );

  Container newImage() {
    return Container(
      width: 72,
      child: WidgetImage(),
    );
  }

  Future<void> processCheckAuthen() async {
    String path =
        'https://www.androidthai.in.th/fluttertraining/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      if (value.toString() == 'null') {
        MyDialog(context: context).normalDialog(
            title: 'User False ?', subTitle: 'No $user in my Database');
      } else {
        print('value ที่อ่านได้จาก api ==> $value');
        var result = json.decode(value.data);
        print('result ==> $result');

        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);
          if (password == userModel.password) {
            //password True

            var datas = <String>[];
            datas.add(userModel.id);
            datas.add(userModel.name);

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setStringList('data', datas).then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/mainHome', (route) => false);
            });
          } else {
            // password False
            MyDialog(context: context).normalDialog(
                title: 'Password False ?',
                subTitle: 'Please Try Again Password False');
          }
        }
      }
    });
  }
}
