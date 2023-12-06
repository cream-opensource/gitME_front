import 'package:flutter/material.dart';

class CustomDrawerBtn extends StatelessWidget {
  const CustomDrawerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft, // 왼쪽 상단으로 정렬
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 45), // 왼쪽 여백과 상단 여백 추가
        child: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black, // 버튼 색상 (검은색)
            size: 30,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}
