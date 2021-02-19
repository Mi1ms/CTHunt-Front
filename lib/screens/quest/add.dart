import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:ct_hunt/widgets/DefaultButton.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/inputs.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:ct_hunt/services/api/quest.dart';
import 'package:ct_hunt/data/colors.dart';

class PositionArguments {
  final double latitude;
  final double longitude;

  PositionArguments({@required this.latitude, @required this.longitude})
      : assert(latitude != null),
        assert(longitude != null);
}

class SuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.71 * SizeConfig.heightMultiplier,
      child: DefaultText(
        value: "Successfully created your quest",
        fontSize: 3.15 * SizeConfig.textMultiplier,
        color: DefaultColors.dark,
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.only(bottom: 3.25 * SizeConfig.heightMultiplier),
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  final IconData iconData;
  final String textValue;
  final Function onTap;

  const BottomSheetItem({Key key, this.onTap, this.iconData, this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(iconData, size: 6.95 * SizeConfig.widthMultiplier),
        title: DefaultText(
          value: textValue,
          color: DefaultColors.primary,
          alignment: Alignment.bottomLeft,
        ),
        onTap: onTap);
  }
}

class RiddleForm extends StatefulWidget {
  final Function done;
  final String address;

  const RiddleForm({Key key, this.done, this.address}) : super(key: key);

  @override
  _RiddleFormState createState() => _RiddleFormState(this.done, this.address);
}

class _RiddleFormState extends State<RiddleForm> {
  _RiddleFormState(this.done, this.address);

  File _image;
  String _level = "";
  String address = "";
  final picker = ImagePicker();
  final Function done;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tipController = TextEditingController();

  void _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void displayToast({BuildContext context, String msg}) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  bool checkState(BuildContext context) {
    if (_level.length == 0) {
      displayToast(context: context, msg: "You have to choose a level");
      return false;
    } else if (_image == null) {
      displayToast(context: context, msg: "You have to add a picture");
      return false;
    }
    return true;
  }

  void sendQuest(BuildContext context) async {
    String title = _titleController.text.trim();
    String description = _titleController.text.trim();
    String tip = _tipController.text.trim();
    PositionArguments args = ModalRoute.of(context).settings.arguments;

    if (checkState(context)) {
      dio.FormData data = dio.FormData.fromMap({
        "title": title,
        "description": description,
        "tip": tip,
        "level": _level,
        "latitude": args.latitude,
        "longitude": args.longitude,
        "solution": await dio.MultipartFile.fromFile(_image.path,
            filename: basename(_image.path))
      });
      try {
        await Quest.add(data);
        done();
      } on dio.DioError catch (e) {
      }
    }
  }

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            child: new Wrap(
              children: [
                BottomSheetItem(
                    iconData: CupertinoIcons.photo_fill,
                    textValue: "Gallery",
                    onTap: () => () {
                          Get.back();
                          _imgFromGallery();
                        }),
                BottomSheetItem(
                    iconData: CupertinoIcons.photo_camera_solid,
                    textValue: "Camera",
                    onTap: () {
                      Get.back();
                      _imgFromCamera();
                    }),
              ],
            ),
          );
        });
  }

  Widget buildAddress() {
    if (address.length > 0)
      return Row(
        children: [
          DefaultText(
            value: "Address: ",
            fontWeight: FontWeight.bold,
          ),
          DefaultText(
            value: address,
          )
        ],
      );
    return DefaultText(
      value: "Invalid address",
      alignment: Alignment.centerLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> radioLabels = [
      'Easy',
      'Medium',
      'Hard',
    ];

    List<String> radioValues = [
      "EASY",
      "MEDIUM",
      "HARD",
    ];
    return Column(children: [
      DefaultText(
        value: "Create a new quest",
        fontSize: 3.25 * SizeConfig.textMultiplier,
        color: DefaultColors.dark,
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.only(bottom: 3.25 * SizeConfig.heightMultiplier),
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              RiddleInput(
                controller: _titleController,
                hint: "Title",
                validator: (String title) {
                  if (title.isEmpty) {
                    return "Enter a title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.25 * SizeConfig.heightMultiplier),
              RiddleInput(
                controller: _descriptionController,
                hint: "Description",
                validator: (String description) {
                  if (description.isEmpty) {
                    return "Enter a description";
                  }
                  return null;
                },
                maxLines: 8,
              ),
              SizedBox(height: 3.65 * SizeConfig.heightMultiplier),
              buildAddress(),
              SizedBox(height: 3.25 * SizeConfig.heightMultiplier),
              Column(children: [
                DefaultText(
                  value: "Select a picture",
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      bottom: 2.03 * SizeConfig.heightMultiplier),
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 32.47 * SizeConfig.heightMultiplier,
                    margin: EdgeInsets.only(
                        bottom: 3.25 * SizeConfig.heightMultiplier),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                          2.5 * SizeConfig.widthMultiplier),
                    ),
                    child: _image == null
                        ? DefaultText(value: 'Select an image')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                                2.5 * SizeConfig.widthMultiplier),
                            child: Image.file(
                              _image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ]),
              RiddleInput(
                controller: _tipController,
                hint: "Enter a tip",
              ),
              SizedBox(height: 3.25 * SizeConfig.heightMultiplier),
              Column(
                children: [
                  DefaultText(
                    value: "Select level of difficulty",
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold,
                    margin: EdgeInsets.only(
                        bottom: 0.81 * SizeConfig.heightMultiplier),
                  ),
                  CustomRadioButton(
                    elevation: 0,
                    unSelectedColor: Colors.white,
                    buttonLables: radioLabels,
                    buttonValues: radioValues,
                    height: 3.25 * SizeConfig.heightMultiplier,
                    width: 23 * SizeConfig.widthMultiplier,
                    spacing: 1.15 * SizeConfig.widthMultiplier,
                    padding: 2.5 * SizeConfig.widthMultiplier,
                    unSelectedBorderColor: DefaultColors.primary,
                    buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(
                            fontSize: 1.95 * SizeConfig.textMultiplier)),
                    radioButtonValue: (value) {
                      setState(() {
                        _level = value;
                      });
                    },
                    selectedBorderColor: DefaultColors.primary,
                    selectedColor: DefaultColors.primary,
                  ),
                  SizedBox(height: 3.25 * SizeConfig.heightMultiplier),
                  DefaultButton(
                    value: "Send my riddle",
                    margin: EdgeInsets.only(
                        bottom: 4.06 * SizeConfig.heightMultiplier),
                    onPress: () {
                      if (_formKey.currentState.validate()) {
                        sendQuest(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ))
    ]);
  }
}

class AddRiddle extends StatefulWidget {
  static const routeName = "/quest/add";

  @override
  _AddRiddleState createState() => _AddRiddleState();
}

class _AddRiddleState extends State<AddRiddle> {
  bool _formSent = false;
  String _address = "";

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  void getAddress() async {
    PositionArguments args = Get.arguments;
    Coordinates coordinates = new Coordinates(args.latitude, args.longitude);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _address = addresses.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _formSent
        ? SuccessView()
        : RiddleForm(
            address: _address,
            done: () {
              setState(() {
                _formSent = true;
              });
            });
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
          content
        ]),
      ),
    )));
  }
}
