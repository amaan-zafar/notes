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
          children: <Widget>[
            Text('Developer'),
            Text('Amaan Zafar'),
            Text('Made in'),
            Text('Flutter'),
          ],
        )));
  }
}
