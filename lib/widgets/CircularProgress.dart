import 'package:flutter/material.dart';
import 'package:ct_hunt/data/colors.dart';
import 'package:ct_hunt/utils/size_config.dart';

class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          DefaultColors.primary),
      strokeWidth: 0.69 * SizeConfig.widthMultiplier,
    );
  }
}