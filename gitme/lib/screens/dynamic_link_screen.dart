import 'package:flutter/material.dart';

class DynamicLinkScreen extends StatefulWidget {
  final String userIdx;
  final String cardIdx;

  DynamicLinkScreen({required this.userIdx, required this.cardIdx});

  @override
  _DynamicLinkPageState createState() => _DynamicLinkPageState();
}

class _DynamicLinkPageState extends State<DynamicLinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Link Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User IDX: ${widget.userIdx}'),
            Text('Card IDX: ${widget.cardIdx}'),
          ],
        ),
      ),
    );
  }
}
