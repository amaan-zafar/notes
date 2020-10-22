import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            CircleAvatar(
              backgroundImage: AssetImage('images/amaan-profile-photo.jpg'),
              radius: 60,
            ),
            Spacer(flex: 1),
            Divider(height: 5),
            Spacer(),
            Text(
              'Amaan Zafar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Spacer(flex: 1),
            Text('BITS Pilani'),
            Spacer(flex: 5),
            Text('Version 1.0'),
            Spacer(flex: 1),
          ],
        )));
  }
}
