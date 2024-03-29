import 'package:flutter/material.dart';
import 'package:tera/helper/Constant.dart';

class CustomOutlinedTextFormField extends StatelessWidget {
  final bool isPassword;
  final TextStyle style;
  final String hintText;
  final String text;
  final String validateEmptyText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final int maxLength;
  final String labelText;
  final String suffixText;
  final ThemeData themeData;
  final bool required;
  final Color hintColor;
  final Color labelColor;
  final Color textColor;

  CustomOutlinedTextFormField({
    this.isPassword = false,
    this.style,
    this.hintText,
    this.text,
    this.validateEmptyText,
    this.controller,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.suffixText,
    this.themeData,
    this.required = true,
    this.hintColor,
    this.labelColor,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      style: TextStyle(fontSize: fontSizeSmall_16 - 2, color: textColor),
      controller: controller,
      keyboardType: keyboardType,
      validator: !required
          ? null
          : (String value) {
              if (value.isEmpty) {
                return validateEmptyText;
              } else {
                return null;
              }
            },
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: fontSizeSmall_16 - 2, color: hintColor),
          contentPadding: EdgeInsets.all(16),
          alignLabelWithHint: true,
          suffixText: suffixText,
          errorStyle: TextStyle(
            fontFamily: "Cairo",
            color: Colors.red,
            fontSize: fontSizeSmall_16 - 2,
          ),
          labelText: labelText,
          labelStyle:
              TextStyle(fontSize: fontSizeSmall_16 - 2, color: labelColor),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
