import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer_btn.dart';
import '../widgets/main_drawer.dart';

class CustomScreen extends StatelessWidget {
  static const route = 'custom-screen';

  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: DraggableText(text: 'drag'),
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: CustomDrawerBtn(),
    );
  }
}
