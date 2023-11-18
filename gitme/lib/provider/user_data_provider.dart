//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'userData.dart';
//
// class UserDataProvider extends StatelessWidget {
//   final Widget child;
//
//   UserDataProvider({required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => UserData(),
//       child: child,
//     );
//   }
//
//   static UserData of(BuildContext context, {bool listen = true}) {
//     return Provider.of<UserData>(context, listen: listen);
//   }
// }
