import 'package:ct_hunt/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct_hunt/widgets/inputs.dart';
import 'package:ct_hunt/screens/quest/home.dart';
import 'package:ct_hunt/services/api/auth.dart';
import 'package:ct_hunt/screens/auth/signUp.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:ct_hunt/data/colors.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "/sign-in";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    String identifier = _identifierController.text.trim();
    String password = _passwordController.text.trim();
    Map<String, dynamic> data = {
      "identifier": identifier,
      "password": password
    };
    try {
      await Auth.login(data);
      Get.offAllNamed(Home.routeName);
    } on dio.DioError catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 7.41 * SizeConfig.widthMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      EdgeInsets.only(top: 3.68 * SizeConfig.heightMultiplier),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: DefaultColors.dark,
                      size: 7.41 * SizeConfig.imageSizeMultiplier,
                    ),
                  ),
                ),
                DefaultText(
                  value: "Sign in",
                  fontSize: 5.15 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold,
                  margin:
                      EdgeInsets.only(top: 6.13 * SizeConfig.heightMultiplier),
                  alignment: Alignment.centerLeft,
                  color: DefaultColors.dark,
                ),
                SizedBox(height: 6.13 * SizeConfig.heightMultiplier),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      IdentifierInput(
                        controller: _identifierController,
                      ),
                      SizedBox(height: 2.45 * SizeConfig.heightMultiplier),
                      PasswordInput(
                        controller: _passwordController,
                      ),
                      SizedBox(height: 18.38 * SizeConfig.heightMultiplier),
                      DefaultButton(
                        value: "Sign in",
                        onPress: () {
                          if (_formKey.currentState.validate()) {
                            login();
                          }
                        },
                      ),
                      DefaultText(
                        value: "Don't have an account?",
                        fontSize: 2.21 * SizeConfig.textMultiplier,
                        color: DefaultColors.dark.withOpacity(0.8),
                        margin: EdgeInsets.only(
                            bottom: 1.23 * SizeConfig.heightMultiplier,
                            top: 4.91 * SizeConfig.heightMultiplier),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(SignUp.routeName);
                        },
                        child: DefaultText(
                          value: "Sign up",
                          fontSize: 2.21 * SizeConfig.textMultiplier,
                          color: DefaultColors.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
