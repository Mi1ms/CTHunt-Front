import 'package:ct_hunt/screens/play/play.dart';
import 'package:ct_hunt/services/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ct_hunt/screens/riddle/home.dart';
import 'package:ct_hunt/screens/auth/landing.dart';
import 'package:ct_hunt/screens/auth/signIn.dart';
import 'package:ct_hunt/screens/auth/signUp.dart';
import 'package:ct_hunt/screens/play/success.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/data/constants.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.preferences = await SharedPreferences.getInstance();
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
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
            home: Auth.isAuth() ? Home() : Landing(),
            routes: {
              Landing.routeName: (context) => Landing(),
              SignUp.routeName: (context) => SignUp(),
              SignIn.routeName: (context) => SignIn(),
              Home.routeName: (context) => Home(),
              Success.routeName: (context) => Success(),
              Play.routeName: (context) => Play(),
            },
          );
        },
      );
    });
  }
}
