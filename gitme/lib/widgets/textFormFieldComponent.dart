import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget TextFormFieldComponent(bool obscureText, TextInputType keyboardType, TextInputAction textInputAction, String hintText, int maxSize, String errorMessage) {
  return Container(
    child: TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.length < maxSize) {
          return errorMessage;
        }
      },
    ),
  );
}
