import 'package:flutter/material.dart';

Widget TextFormFieldComponent(
    TextInputType keyboardType,
    TextInputAction textInputAction,
    String hintText,
    int maxSize,
    String errorMessage,
    TextEditingController controller,
    void Function(String?)? onSaved,
    String labelText, // 새로 추가한 속성: 폼 위의 라벨 텍스트
    ) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText, // 라벨 텍스트 추가
        labelStyle: TextStyle(fontWeight: FontWeight.bold), // 라벨 폰트를 bold체로 설정
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '입력 필수 항목입니다.';
        } else if (value.length < maxSize) {
          return errorMessage;
        }
        return null; // 유효성 검사 통과
      },
      onSaved: onSaved,
      controller: controller,
    ),
  );
}
