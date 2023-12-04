import 'package:flutter/material.dart';

Widget IntroduceFormFieldComponent(
    TextInputType keyboardType,
    TextInputAction textInputAction,
    String hintText,
    int maxSize,
    String errorMessage,
    TextEditingController controller,
    void Function(String?)? onSaved,
    String labelText,
    ) {

  return Container(
    height: 100,
    margin: EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: 4,  // 여러 줄 입력을 위한 설정
      maxLength: maxSize, // 최대 글자 수 제한
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16.5,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8D919F),
          fontFamily: 'DarkerGrotesque',
        ),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '입력 필수 항목입니다.';
        } else if (value.length > maxSize) {
          return errorMessage;
        }
        return null; // 유효성 검사 통과
      },
      onSaved: onSaved,
      controller: controller,
    ),
  );

}
