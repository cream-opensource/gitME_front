import 'package:flutter/material.dart';

class DynamicLinkScreen extends StatefulWidget {
  final String userIdx;
  final String templateIdx;

  DynamicLinkScreen({required this.userIdx, required this.templateIdx});

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
            Text('Template IDX: ${widget.templateIdx}'),
          ],
        ),
      ),
    );
  }
}
