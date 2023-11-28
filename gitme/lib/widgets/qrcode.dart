import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: QrImageView(
            data: "Hello, QR Code!",
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ),
    );
  }
}
