import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/header_light_theme.png');
    Image image = Image(
      image: assetImage,
      width: 10,
    );
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Spacer(flex: 5),
            CircleAvatar(
              backgroundColor: Color(0xffff5c5c),
              radius: 9,
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Color(0xffffde59),
              radius: 9,
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 9,
            ),
            Spacer(
              flex: 18,
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Text('NOTEPAD',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Times',
              color: Colors.white,
            )),
      ],
    ));
  }
}
