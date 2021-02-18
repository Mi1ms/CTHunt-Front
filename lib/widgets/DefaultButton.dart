import 'package:flutter/material.dart';
import 'package:ct_hunt/data/colors.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';

class DefaultButton extends StatelessWidget {
  final Function onPress;
  final Color backgroundColor;
  final Color highlightColor;
  final Color textColor;
  final double widthPercentage;
  final double width;
  final Widget child;
  final String value;
  final double fontSize;
  final FontWeight fontWeight;
  final Alignment textAlignment;
  final EdgeInsets margin;
  final bool uppercase;
  final bool hasWidthPercentage;
  final EdgeInsets padding;

  DefaultButton(
      {Key key,
      this.onPress,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.widthPercentage = 0.9,
      this.child,
      this.value,
      this.fontSize,
      this.fontWeight = FontWeight.w600,
      this.highlightColor,
      this.margin,
      this.padding,
      this.uppercase = true,
      this.textAlignment = Alignment.center,
      this.width,
      this.hasWidthPercentage = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: hasWidthPercentage ? MediaQuery.of(context).size.width * widthPercentage : width,
      margin: margin,
      child: FlatButton(
        onPressed: onPress,
        highlightColor: highlightColor,
        color: backgroundColor ?? DefaultColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(4.29 * SizeConfig.heightMultiplier),
        ),
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(vertical: 2.94 * SizeConfig.heightMultiplier),
          child: child ??
              DefaultText(
                value: uppercase ? value.toUpperCase() : value,
                alignment: textAlignment,
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize ?? 2.21  * SizeConfig.textMultiplier,
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }
}
