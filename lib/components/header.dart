import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Notepad',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Colors.white),
        ),
        Text(
          '.',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Color(0xffff5c5c)),
        ),
        Text(
          '.',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Color(0xffffde59)),
        ),
        Text(
          '.',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Colors.white),
        )
        // CircleAvatar(
        //   backgroundColor: Color(0xffff5c5c),
        //   radius: 6,
        // ),
        // SizedBox(width: 6),
        // CircleAvatar(
        //   backgroundColor: Color(0xffffde59),
        //   radius: 6,
        // ),
        // SizedBox(width: 6),
        // CircleAvatar(
        //   backgroundColor: Colors.white,
        //   radius: 6,
        // ),
      ],
    ));
  }
}
