import 'package:flutter/material.dart';
import 'package:notes/screens/about.dart';
import 'package:notes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'header.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
        child: Drawer(
      child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Header(),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
                leading: Icon(Icons.note_add),
                title: Text('Notes'),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.delete),
                title: Text('Trash'),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('About App'),
                onTap: () {
                  navigateToAbout(context);
                }),
            SwitchListTile(
              activeColor: Colors.blue,
              title: Text('App Theme'),
              onChanged: (bool value) {
                themeChange.darkTheme = value;
              },
              value: themeChange.darkTheme,
            )
          ]),
    ));
  }

  void navigateToAbout(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return About();
    }));
  }
}
