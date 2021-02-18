import 'dart:io';

import 'package:ct_hunt/data/images.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() => runApp(Play());

class Play extends StatelessWidget {
  static const String routeName = '/mission';
  String description = 'Une enigme...';
  String tips = 'Un indice supplementaire...';
  String title = 'Nom de l\'énigme';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Enigme',
        home: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Image.asset(Images.winnerIllustration,
                    width: double.infinity, fit: BoxFit.fitWidth),
                Container(
                  width: 900,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      value: title,
                      fontSize: 3.68 * SizeConfig.textMultiplier,
                      margin: EdgeInsets.only(
                          top: 7.35 * SizeConfig.heightMultiplier),
                      fontWeight: FontWeight.bold,
                    ),
                    DefaultText(
                      value: description,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                        left:
                            BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                        right:
                            BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
                        bottom:
                            BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 30),
                      backgroundColor: Colors.white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          child: RaisedButton(
                              onPressed: () async {
                                print('camera');
                                File image = await ImagePicker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 50);
                              },
                              child: Icon(Icons.camera)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                        ),
                        SizedBox(
                          height: 3.68 * SizeConfig.heightMultiplier,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          // padding: EdgeInsets.symmetric(vertical: 30),
                          icon: Icon(
                            Icons.flag_rounded,
                            color: Colors.red,
                            size: 50,
                          ),
                          onPressed: () {
                            print('Flag');
                          },
                          tooltip: 'Signaler',
                          // )),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.help_outlined,
                            size: 50,
                          ),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              headerAnimationLoop: false,
                              dialogType: DialogType.QUESTION,
                              animType: AnimType.TOPSLIDE,
                              title: 'Coup de pouce ?',
                              desc: tips,
                              // btnCancelText: 'X',
                              // btnCancelOnPress: () {},
                            )..show();
                          },
                          tooltip: 'Signaler',
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
