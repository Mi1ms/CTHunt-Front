import 'package:ct_hunt/utils/size_config.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ct_hunt/screens/auth/signIn.dart';
import 'package:ct_hunt/screens/quest/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct_hunt/widgets/inputs.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:ct_hunt/data/colors.dart';
import 'package:ct_hunt/services/api/auth.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "/sign-up";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void register() async {
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    Map<String, dynamic> data = {"email": email, "username": username, "password": password};

    try {
      await Auth.register(data);
      Get.offAllNamed(Home.routeName);
    } on dio.DioError catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.41 * SizeConfig.widthMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 3.68 * SizeConfig.heightMultiplier),
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
                  value: "Sign up",
                  fontSize: 5.15 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.only(top: 6.13 * SizeConfig.heightMultiplier),
                  alignment: Alignment.centerLeft,
                  color: DefaultColors.dark,
                ),
                SizedBox(height: 6.13 * SizeConfig.heightMultiplier),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      UsernameInput(
                        controller: _usernameController,
                      ),
                      SizedBox(height: 2.45 * SizeConfig.heightMultiplier),
                      EmailInput(
                        controller: _emailController,
                      ),
                      SizedBox(height: 2.45 * SizeConfig.heightMultiplier),
                      PasswordInput(
                        controller: _passwordController,
                      ),
                      SizedBox(height: 9.81 * SizeConfig.heightMultiplier),
                      DefaultButton(
                        value: "Sign up",
                        onPress: () {
                          if (_formKey.currentState.validate()) {
                            register();
                          }
                        },
                      ),
                      DefaultText(
                        value: "Already have an account?",
                        fontSize: 2.21 * SizeConfig.textMultiplier,
                        color: DefaultColors.dark.withOpacity(0.8),
                        margin: EdgeInsets.only(bottom: 1.23* SizeConfig.heightMultiplier, top: 4.91 * SizeConfig.heightMultiplier),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(SignIn.routeName);
                        },
                        child: DefaultText(
                          value: "Sign in",
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
