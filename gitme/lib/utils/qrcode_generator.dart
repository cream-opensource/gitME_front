import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String qrData = "https://www.example.com"; // QR 코드에 포함될 데이터

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QRCodeGenerator(),
  ));
}
