import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class QRScanScreen extends StatefulWidget {
  static const route = 'qrscan-screen';

  const QRScanScreen({super.key});

  @override
  _QRScanScreen createState() => _QRScanScreen();
}

class _QRScanScreen extends State<QRScanScreen> {
  String _output = 'Empty Scan Code';
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Text(_output, style: TextStyle(color: Colors.black)),);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scan(),
          tooltip: 'scan',
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  Future _scan() async {
    String? barcode = await scanner.scan();
    setState(() => _output = barcode!);
  }
}