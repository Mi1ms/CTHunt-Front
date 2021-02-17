import 'package:ct_hunt/data/images.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:flutter/material.dart';

void main() => runApp(Play());

class Play extends StatelessWidget {
  static const String routeName = '/mission';
  String description = 'Une enigme...';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Enigme',
        home: Scaffold(
          backgroundColor: Colors.indigoAccent,
          body: SafeArea(
            child: Stack(
              children: [
                Image.asset(Images.homeIllustration,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover),
                Container(
                  width: 900,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      value: "Enigme",
                      fontSize: 3.68 * SizeConfig.textMultiplier,
                      margin: EdgeInsets.only(
                          top: 7.35 * SizeConfig.heightMultiplier),
                      fontWeight: FontWeight.bold,
                    ),
                    DefaultText(
                      value: description,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          child: RaisedButton(
                            onPressed: () {
                              print('camera');
                            },
                            child: DefaultText(
                              value: 'J\'ai !',
                            ),
                          ),
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
                            print('Help');
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
