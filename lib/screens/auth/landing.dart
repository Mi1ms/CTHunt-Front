import 'package:ct_hunt/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ct_hunt/data/images.dart';
import 'package:ct_hunt/screens/auth/signIn.dart';
import 'package:ct_hunt/screens/auth/signUp.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';

class Landing extends StatelessWidget {
  static const routeName = "/landing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            value: "CTHunt",
            fontSize: 4.91 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.w900,
            color: DefaultColors.dark,
            margin: EdgeInsets.only(top: 9.81 * SizeConfig.heightMultiplier),
          ),
          Image.asset(
              Images.homeIllustration,
              width: double.infinity,
              height: 49.01 * SizeConfig.heightMultiplier
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2.45 * SizeConfig.heightMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: DefaultButton(
                    value: "Sign in",
                    onPress: () {
                      Get.toNamed(SignIn.routeName);
                    },
                    margin: EdgeInsets.only(
                        bottom: 3.68 * SizeConfig.heightMultiplier
                    ),
                  ),
                ),

                Center(
                  child: GestureDetector(
                    onTap: (){
                          Get.toNamed(SignUp.routeName);
                    },
                    child: DefaultText(
                      value: "Sign up".toUpperCase(),
                      padding: EdgeInsets.symmetric(vertical: 2.94 * SizeConfig.heightMultiplier),
                      color: DefaultColors.primary,
                      fontWeight:  FontWeight.w600,
                      fontSize: 2.21  * SizeConfig.textMultiplier,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
