import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ct_hunt/data/colors.dart';
import 'package:ct_hunt/data/images.dart';
import 'package:ct_hunt/data/models.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';

class PlayArguments {
  final Quest quest;

  PlayArguments({this.quest = const Quest()});
}

class Play extends StatelessWidget {
  static const String routeName = '/play';
  final picker = ImagePicker();


  void _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {

    }
  }


  @override
  Widget build(BuildContext context) {
    PlayArguments args = ModalRoute.of(context).settings.arguments;
    String tip = args.quest.tip != null && args.quest.tip.length > 0
        ? args.quest.tip
        : "No tip, you're on your own 😔";

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 7.41 * SizeConfig.widthMultiplier),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                top: 3.68 * SizeConfig.heightMultiplier,
                bottom: 4.91 * SizeConfig.heightMultiplier),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                CupertinoIcons.back,
                color: DefaultColors.dark,
                size: 7.41 * SizeConfig.widthMultiplier,
              ),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Image.asset(
                Images.playIllustration,
                width: 46.29 * SizeConfig.widthMultiplier,
                height: 17.16 * SizeConfig.heightMultiplier,
                fit: BoxFit.cover,
              ),
            ),
            DefaultText(
              value: "My title",
              fontSize: 2.45 * SizeConfig.textMultiplier,
              color: DefaultColors.dark,
              fontWeight: FontWeight.bold,
              margin:
                  EdgeInsets.only(bottom: 1.96 * SizeConfig.heightMultiplier, top: 3.67 * SizeConfig.heightMultiplier),
            ),
            Container(
              padding: EdgeInsets.all(2.31 * SizeConfig.widthMultiplier),
              margin: EdgeInsets.only(bottom: 3.92 * SizeConfig.heightMultiplier),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.23 * SizeConfig.widthMultiplier, color: DefaultColors.dark)),
              child: DefaultText(
                value: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc volutpat in erat auctor suscipit. Nulla sed ultricies justo. Aliquam erat volutpat. Morbi eget lorem in metus ultrices blandit. Vestibulum malesuada bibendum sapien in volutpat. Etiam vitae arcu vitae nulla ultrices condimentum. Donec finibus vestibulum suscipit. Ut tempus nisi nec odio vulputate, ac euismod nisl placerat. Morbi iaculis sapien nisl, rhoncus interdum enim sodales non. Nam sed tempor eros.",
                color: DefaultColors.dark,
              ),
            ),
            Row(
              children: [
                DefaultText(
                  value: "Level: ",
                  fontSize: 2.45 * SizeConfig.textMultiplier ,
                  fontWeight: FontWeight.w600,
                  color: DefaultColors.dark,
                ),
                DefaultText(
                  value: args.quest.level.capitalize,
                  fontSize: 2.45 * SizeConfig.textMultiplier,
                  color: DefaultColors.primary[600],
                ),
              ],
            ),
            SizedBox(height: 3.68 * SizeConfig.heightMultiplier),
            Center(
              child: FittedBox(
                child: InkWell(
                  onTap: () {
                    _imgFromCamera();
                  },
                  child: DefaultText(
                    value: "Got it",
                    padding: EdgeInsets.symmetric(vertical: 0.98 * SizeConfig.heightMultiplier, horizontal: 6.02 * SizeConfig.widthMultiplier),
                    margin: EdgeInsets.only(top: 0.74 * SizeConfig.heightMultiplier),
                    fontSize: 2.45 * SizeConfig.textMultiplier,
                    backgroundColor: DefaultColors.primary[600],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.85 * SizeConfig.widthMultiplier),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.68 * SizeConfig.heightMultiplier),
            IconButton(
              icon: Icon(
                Icons.help_outlined,
                size: 11.57 * SizeConfig.widthMultiplier,
              ),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.QUESTION,
                  animType: AnimType.TOPSLIDE,
                  title: 'Want a tip ?',
                  desc: tip,
                  // btnCancelText: 'X',
                  // btnCancelOnPress: () {},
                )..show();
              },
              // tooltip: 'Signaler',
            )
          ])
        ]),
      ),
    )));
  }
}
