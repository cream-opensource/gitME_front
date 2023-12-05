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
    print('Building GitHubButton. isLinked: $isLinked');

    return Row(
          children: [
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton.icon(
                  onPressed: () async {


                    print('GitHubButton onPressed.');
                    String githubLoginUrl = 'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/github/login';

                    // Navigate to the GitHubLoginWebView using push, not pushReplacement
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GitHubLoginWebView(
                          githubLoginUrl: githubLoginUrl,
                          onLinked: () {
                            print('onLinked callback triggered.');
                            setState(() {
                              isLinked = true;
                            });
                          },
                        ),
                      ),
                    );

                    // After returning from GitHubLoginWebView, GitHubButton will still be part of the widget tree
                    // and the state (isLinked) will be preserved
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF56CC94),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 모서리 조절
                    ),
                  ),
                  icon: Image.asset(
                    isLinked ? 'assets/git_icon.png' : 'assets/git_icon_white.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  label: Text("GitHub 연동"),
                ),
              ),
            ),
          ],
        );
  }
}
