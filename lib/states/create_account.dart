import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungmenber/utility/my_constant.dart';
import 'package:ungmenber/utility/my_dialog.dart';
import 'package:ungmenber/widgets/widget_button.dart';
import 'package:ungmenber/widgets/widget_form.dart';
import 'package:ungmenber/widgets/widget_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: WidgetText(
          text: 'Create New Account',
          textStyle: MyConstant().h2Style(),
        ),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          onTap: () {
            return FocusScope.of(context).requestFocus(FocusScopeNode());
          },
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              newCenter(boxConstraints,
                  widget: WidgetForm(
                    hint: 'Name:',
                    iconData: Icons.fingerprint,
                    changeFunc: (p0) {
                      name = p0.trim();
                    },
                  )),
              newCenter(boxConstraints,
                  widget: WidgetForm(
                    hint: 'User:',
                    iconData: Icons.person_outline,
                    changeFunc: (p0) {
                      user = p0.trim();
                    },
                  )),
              newCenter(boxConstraints,
                  widget: WidgetForm(
                    hint: 'Password:',
                    iconData: Icons.lock_outline,
                    changeFunc: (p0) {
                      password = p0.trim();
                    },
                  )),
              newCenter(boxConstraints,
                  widget: WidgetButton(
                    label: 'Create New Account',
                    pressFunc: () {
                      print('name = $name, user = $user, password = $password');

                      if ((name?.isEmpty ?? true) ||
                          (user?.isEmpty ?? true) ||
                          (password?.isEmpty ?? true)) {
                        //Have Space
                        MyDialog(context: context).normalDialog(
                            title: 'Have Space ?',
                            subTitle: 'Please Fill Every Blank');
                      } else {
                        //No Spave
                        processCheckUser();
                      }
                    },
                  )),
            ],
          ),
        );
      }),
    );
  }

  Row newCenter(BoxConstraints boxConstraints, {required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: boxConstraints.maxWidth * 0.6,
          child: widget,
        ),
      ],
    );
  }

  Future<void> processCheckUser() async {
    String path =
        'https://www.androidthai.in.th/fluttertraining/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      print('value ==> $value');

      if (value.toString() == 'null') {
        //user true
        processInsertNewUser();
      } else {
        //user false
        MyDialog(context: context).normalDialog(
            title: 'User False ?',
            subTitle: '$user have alreday please Change User');
      }
    });
  }

  Future<void> processInsertNewUser() async {
    String path =
        'https://www.androidthai.in.th/fluttertraining/insertUserUng.php?isAdd=true&name=$name&user=$user&password=$password';
    await Dio().get(path).then((value) {
      
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        MyDialog(context: context).normalDialog(
            title: 'Error', subTitle: 'Cannot Create Account Please Try Again');
      }
    });
  }
}
