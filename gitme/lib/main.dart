import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/screens/cardList_screen.dart';
import 'package:gitme/screens/cardWallet_screen.dart';
import 'package:gitme/screens/custom_screen.dart';
import 'package:gitme/screens/dynamic_link_screen.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/join_screen.dart';
import 'package:gitme/screens/loading_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/screens/profile_screen.dart';
import 'package:gitme/screens/qr_scan_screen.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  mainAsync();
}

void mainAsync() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MyApp(),
    ),
  );

  // 동적 링크 처리
  handleDynamicLink();
}

Future<void> handleDynamicLink() async {
  try {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();

    if (data != null && data.link != null) {
      final queryParams = data.link.queryParameters;
      final userIdx = queryParams['userIdx'] ?? '';
      final cardIdx = queryParams['cardIdx'] ?? '';

      if (userIdx.isNotEmpty && cardIdx.isNotEmpty) {
        navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                DynamicLinkScreen(userIdx: userIdx, cardIdx: cardIdx)));
      }
    }
  } catch (e) {
    print('Error handling dynamic link: ${e.toString()}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Drawer without AppBar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        MainScreen.route: (_) => MainScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        CardListScreen.route: (_) => CardListScreen(),
        ProfileScreen.route: (_) => ProfileScreen(),
        CardWalletScreen.route: (_) => CardWalletScreen(),
        CustomScreen.route: (_) => CustomScreen(),
        JoinScreen.route: (_) => JoinScreen(),
        QRScanScreen.route: (_) => QRScanScreen(),
        LoadingScreen.route: (_) => LoadingScreen(),
        ExternalLinkScreen.route: (_) => ExternalLinkScreen()
      },
    );
  }
}