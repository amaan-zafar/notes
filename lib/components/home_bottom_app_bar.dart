import 'package:flutter/material.dart';

class HomeBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.check_box),
              onPressed: () {
                // Navigate to Checkbox Lists Screen
              },
            ),
            IconButton(
              icon: Icon(Icons.brush),
              onPressed: () {
                // Navigate to Drawing Screen
              },
            ),
            // Will implement later
            // IconButton(
            //   icon: Icon(Icons.mic),
            //   onPressed: () {
            //     // For voice input
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: () {
                // Image input
              },
            ),
          ],
        ));
  }
}
