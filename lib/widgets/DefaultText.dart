import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String value;
  final String fontFamily;
  final Alignment alignment;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final int maxLines;
  final int maxLength;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final double letterSpacing;
  final double lineHeight;
  final BoxBorder border;
  final BorderRadius borderRadius;

  const DefaultText(
      {Key key,
      this.width,
      this.value,
      this.maxLines,
      this.overflow,
      this.fontFamily,
      this.color = Colors.black,
      this.fontSize,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = Colors.transparent,
      this.margin = const EdgeInsets.all(0),
      this.textAlign,
      this.alignment = Alignment.center,
      this.letterSpacing,
      this.lineHeight,
      this.border,
      this.maxLength,
      this.padding = const EdgeInsets.all(0),
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
          color: backgroundColor, border: border, borderRadius: borderRadius),
      child: Text(value,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          style: TextStyle(
              letterSpacing: letterSpacing,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              height: lineHeight
          )
      ),
    );
  }
}
