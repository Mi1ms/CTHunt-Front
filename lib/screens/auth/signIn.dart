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
    Map<String, dynamic> data = {"identifier": identifier, "password": password};
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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: DefaultColors.dark,
                      size: 32,
                    ),
                  ),
                ),
                DefaultText(
                  value: "Sign in",
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.centerLeft,
                  color: DefaultColors.dark,
                ),
                SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      IdentifierInput(
                        controller: _identifierController,
                      ),
                      SizedBox(height: 20),
                      PasswordInput(
                        controller: _passwordController,
                      ),
                      SizedBox(height: 150),
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
                        fontSize: 18,
                        color: DefaultColors.dark.withOpacity(0.8),
                        margin: EdgeInsets.only(bottom: 10, top: 40),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(SignUp.routeName);
                        },
                        child: DefaultText(
                          value: "Sign up",
                          fontSize: 18,
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
