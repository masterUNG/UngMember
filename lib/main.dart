import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmenber/states/authen.dart';
import 'package:ungmenber/states/desktop_main.dart';
import 'package:ungmenber/states/main_home.dart';
import 'package:ungmenber/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/mainHome': (context) => const MainHome(),
  '/desktopMain': (context) => const DeskTopMain(),
};

String firstState = '/authen';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverride();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var result = preferences.getStringList('data');
  print('result @ main.dart ==> $result');

  if (Platform.isMacOS) {
    firstState = '/desktopMain';
    runApp(const MyApp());
  } else {
    if (result != null) {
      firstState = '/mainHome';
    }

    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstState,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: MyConstant.dark,
          elevation: 0,
        ),
      ),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
