import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget TextFormFieldComponent(TextInputType keyboardType, TextInputAction textInputAction, String hintText, int maxSize, String errorMessage, TextEditingController controller, void Function(String?)? onSaved) {
  return Container(
    child: TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.length < maxSize) {
          return errorMessage;
        }
        return null; // 유효성 검사 통과
      },
      onSaved: onSaved,
      controller: controller,
    ),
  );
}



