import 'package:flutter/material.dart';

import '../service/apiService.dart';

class LoadingScreen extends StatefulWidget {
  static const route = 'loading-screen';
  final Function onLoadingComplete;

    const LoadingScreen({super.key, required this.onLoadingComplete});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final DataHandler serverCommunication = DataHandler();
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      await serverCommunication.fetchDataFromServer(context);
      widget.onLoadingComplete();
      print('성공');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중인 경우 로딩 화면을 보여줌
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 에러가 발생한 경우 에러 메시지를 보여줄 수 있음
            return Text('Error: ${snapshot.error}');
          } else {
            // 데이터를 성공적으로 받아온 경우 MainScreen으로 이동
            // Navigator.of(context).pushReplacementNamed(MainScreen.route);
            return Container(); // 빈 컨테이너를 반환하여 에러를 방지
          }
        },
      ),
    );
  }
}
