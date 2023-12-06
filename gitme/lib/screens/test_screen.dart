// import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;  // 여기서 qrscan이라는 별칭을 사용하고 있음
// import 'package:flutter/material.dart';
//
// class TestScreen extends StatefulWidget {
//   static const route = 'test-screen';
//
//   const TestScreen({super.key});
//
//   @override
//   _testState createState() => _testState();
// }
//
// class _testState extends State<TestScreen> {
//   late TextEditingController _outputController;
//
//   @override
//   initState() {
//     super.initState();
//     _outputController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.grey[300],
//         body: Builder(
//           builder: (BuildContext context) {
//             return ListView(
//               children: <Widget>[
//                 Container(
//                   color: Colors.white,
//                   child: Column(
//                     children: <Widget>[
//                       TextField(
//                         controller: _outputController,
//                         maxLines: 2,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.wrap_text),
//                           helperText:
//                           'The barcode or qrcode you scan will be displayed in this area.',
//                           hintText:
//                           'The barcode or qrcode you scan will be displayed in this area.',
//                           hintStyle: TextStyle(fontSize: 15),
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: 7, vertical: 15),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       _buttonGroup(),
//                       SizedBox(height: 70),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _scan(),
//           tooltip: 'Take a Photo',
//           child: const Icon(Icons.camera_alt),
//         ),
//       ),
//     );
//   }
//
//   Widget _buttonGroup() {
//     return Row(
//       children: <Widget>[
//         Expanded(
//           flex: 1,
//           child: SizedBox(
//             height: 120,
//             child: InkWell(
//               onTap: _scan,
//               child: Card(
//                 child: Column(
//                   children: <Widget>[
//                     Expanded(
//                       flex: 2,
//                       child: Image.asset('images/scanner.png'),
//                     ),
//                     Divider(height: 20),
//                     Expanded(flex: 1, child: Text("Scan")),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Other buttons can be added here if needed
//       ],
//     );
//   }
//
//   Future _scan() async {
//     await Permission.camera.request();
//     String? barcode = await scanner.scan();  // 여기서 scan 함수가 qrscan 라이브러리의 scan 함수를 호출하고 있음
//     if (barcode == null) {
//       print('nothing return.');
//     } else {
//       _outputController.text = barcode;
//     }
//   }
// }
