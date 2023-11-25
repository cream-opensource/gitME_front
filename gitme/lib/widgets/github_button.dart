import 'package:flutter/material.dart';
import 'githubLoginWebView.dart';

class GitHubButton extends StatefulWidget {
  @override
  _GitHubButtonState createState() => _GitHubButtonState();
}

class _GitHubButtonState extends State<GitHubButton> {
  bool isLinked = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: ElevatedButton.icon(
        onPressed: () {
          String githubLoginUrl =
              'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/github/login';
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GitHubLoginWebView(
                githubLoginUrl: githubLoginUrl,
                onLinked: () {
                  setState(() {
                    isLinked = true;
                  });
                },
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isLinked ? Colors.black : Colors.grey,
          foregroundColor: Colors.white,
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        icon: Image.asset(
          isLinked ? 'assets/git_icon.png' : 'assets/git_icon_white.png',
          height: 24.0,
          width: 24.0,
        ),
        label: Text("GitHub 연동"),
      ),
    );
  }
}
