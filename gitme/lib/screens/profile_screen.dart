import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:flutter/material.dart';



class ProfileScreen extends StatefulWidget {
  static const route = 'profile-screen';

  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomDrawerBtn(),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image(
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage('assets/cream.png'),
              ),
              Positioned(
                bottom: 10,
                child: Image(
                  height: 120,
                  width: 120,
                  image: AssetImage('assets/default-user.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Hoon'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text('your@email.com'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('000-0000-0000'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('1998.12.11'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),

    );
  }
}