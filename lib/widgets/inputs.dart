import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct_hunt/data/colors.dart';
import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:ct_hunt/widgets/DefaultInput.dart';
import 'package:ct_hunt/utils/size_config.dart';

class CommonInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Function validator;
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final String label;
  final String hint;
  final TextStyle hintStyle;
  final bool obscureText;
  final Widget prefixIcon;
  final double fontSize;
  final int maxLines;

  const CommonInput(
      {Key key,
      this.controller,
      this.inputType,
      this.validator,
      this.label = "",
      this.obscureText = false,
      this.margin = const EdgeInsets.all(0),
      this.hint,
      this.prefixIcon,
      this.contentPadding,
      this.fontSize,
      this.hintStyle,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget Label = label.isNotEmpty
        ? DefaultText(
            value: label,
            fontSize: fontSize ?? 1.96 * SizeConfig.textMultiplier,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 0.98 * SizeConfig.heightMultiplier),
            color: DefaultColors.dark.withOpacity(0.8),
          )
        : SizedBox();

    return Container(
      margin: margin,
      child: Column(
        children: [
          Label,
          DefaultInput(
            controller: controller,
            inputType: inputType,
            color: DefaultColors.dark,
            fontSize: 1.96 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.w500,
            obscureText: obscureText,
            maxLines: maxLines,
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: hintStyle,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                      horizontal: 2.31 * SizeConfig.widthMultiplier,
                      vertical: 1.96 * SizeConfig.heightMultiplier
                  ),
              prefixIcon: prefixIcon,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets margin;

  const EmailInput({Key key, @required this.controller, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonInput(
      controller: controller,
      inputType: TextInputType.emailAddress,
      label: "Email",
      hint: "john.doe@example.com",
      margin: margin,
      validator: (String email) {
        bool emailIsValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
        if (email.isEmpty) {
          return 'Enter your email';
        } else if (!emailIsValid) {
          return 'Email invalid';
        }
        return null;
      },
    );
  }
}

class IdentifierInput extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets margin;

  const IdentifierInput({Key key, @required this.controller, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonInput(
      controller: controller,
      inputType: TextInputType.emailAddress,
      label: "id",
      hint: "Username or email",
      margin: margin,
      validator: (String identifier) {
        if (identifier.isEmpty) {
          return 'Enter your identifier';
        }
        return null;
      },
    );
  }
}

class UsernameInput extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets margin;

  const UsernameInput({Key key, @required this.controller, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonInput(
      controller: controller,
      inputType: TextInputType.emailAddress,
      label: "Username",
      hint: "John doe",
      margin: margin,
      validator: (String username) {
        if (username.isEmpty) {
          return 'Enter your username';
        }
        return null;
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets margin;

  const PasswordInput({Key key, @required this.controller, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonInput(
      controller: controller,
      obscureText: true,
      margin: margin,
      label: "Password",
      hint: "*********",
      validator: (String password) {
        if (password.isEmpty) {
          return 'Enter your password';
        } else if (password.length < 6) {
          return 'Password should contain at least 6 characters';
        }
        return null;
      },
    );
  }
}

class RiddleInput extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets margin;
  final int maxLines;
  final String hint;
  final Function(String value) validator;

  const RiddleInput(
      {Key key,
      @required this.controller,
      this.margin,
      this.maxLines,
      @required this.hint,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonInput(
      controller: controller,
      inputType: TextInputType.text,
      hint: hint,
      margin: margin,
      maxLines: maxLines,
      validator: validator,
      contentPadding: EdgeInsets.all(0),
    );
  }
}
