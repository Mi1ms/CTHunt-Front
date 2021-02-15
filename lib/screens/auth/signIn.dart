import 'package:flutter/material.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultInput.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "/sign-in";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultText(
            value: "Sign in",
            fontSize: 30,
            fontWeight: FontWeight.w600,
            margin: EdgeInsets.only(top: 50),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DefaultInput(
                  controller: _emailController,
                  label: "Email",
                  validator: (String email) {
                    if(email.isEmpty) return "Email required";
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DefaultInput(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                  validator: (String password) {
                    if(password.isEmpty) return "Password required";
                    return null;
                  },
                ),
                SizedBox(height: 30),

                DefaultButton(
                  value: "Sign in",
                  onPress: (){
                    if (_formKey.currentState.validate()) {
                      print("----------------------------Sign in------------------------------------------");
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
