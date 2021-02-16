import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ct_hunt/screens/riddle/home.dart';
import 'package:ct_hunt/screens/auth/landing.dart';
import 'package:ct_hunt/screens/auth/signIn.dart';
import 'package:ct_hunt/screens/auth/signUp.dart';
import 'package:ct_hunt/utils/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
            routes: {
              Landing.routeName: (context) => Landing(),
              SignUp.routeName: (context) => SignUp(),
              SignIn.routeName: (context) => SignIn(),
              Home.routeName: (context) => Home(),
            },
          );
        },
      );
    });
  }
}
