import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ct_hunt/data/images.dart';
import 'package:ct_hunt/screens/auth/signIn.dart';
import 'package:ct_hunt/screens/auth/signUp.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(Images.homeIllustration, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.4),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  value: "Welcome in CThunt",
                  fontSize: 3.68 * SizeConfig.textMultiplier,
                  margin: EdgeInsets.only(top: 7.35 * SizeConfig.heightMultiplier),
                  fontWeight: FontWeight.bold,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: DefaultButton(
                        value: "Sign up",
                        onPress: () {
                          Get.toNamed(SignUp.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.68 * SizeConfig.heightMultiplier,
                    ),
                    Center(
                      child: DefaultButton(
                        value: "Sign in",
                        onPress: () {
                          Get.toNamed(SignIn.routeName);
                        },
                        margin: EdgeInsets.only(bottom: 3.68 * SizeConfig.heightMultiplier),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
