import 'package:flutter/material.dart';

class DefaultInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String value) onChanged;
  final VoidCallback initInputState;
  final String hint;
  final String label;
  final String initialValue;
  final double widthPercentage;
  final bool obscureText;
  final EdgeInsets contentPadding;
  final Widget icon;
  final Widget iconButton;
  final EdgeInsets margin;
  final Function validator;
  final Decoration decoration;
  final Color color;
  final double fontSize;
  final TextStyle style;
  final FontWeight fontWeight;
  final InputDecoration inputDecoration;
  final int minLines;
  final int maxLength;
  final int maxLines;

  const DefaultInput(
      {Key key,
      @required this.controller,
      this.inputType,
      this.hint,
      this.label,
      this.widthPercentage = 0.9,
      this.obscureText = false,
      this.contentPadding,
      this.icon,
      this.iconButton,
      this.margin,
      this.validator,
      this.decoration,
      this.inputDecoration,
      this.color,
      this.fontSize,
      this.style,
      this.fontWeight,
      this.minLines,
      this.maxLength,
      this.maxLines,
      this.initialValue,
      this.onChanged, this.initInputState})
      : super(key: key);

  @override
  _DefaultInputState createState() => _DefaultInputState();
}

class _DefaultInputState extends State<DefaultInput> {
  @override
  void initState() {
    super.initState();
    if (widget.initInputState != null) widget.initInputState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widget.widthPercentage,
      margin:
          widget.margin ,
      decoration: widget.decoration,
      child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          style: widget.style ??
              TextStyle(
                color: widget.color,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
              ),
          decoration: widget.inputDecoration ??
              InputDecoration(
                  hintText: widget.hint,
                  labelText: widget.label,
                  labelStyle: TextStyle(color: Colors.red),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 14)),
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(
                          horizontal: 12),
                  suffixIcon: widget.icon ?? widget.iconButton)
      ),
    );
  }
}
