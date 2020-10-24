import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Spacer(),
            CircleAvatar(
              backgroundImage: AssetImage('images/amaan-profile-photo.jpg'),
              radius: 60,
            ),
            Spacer(),
            Divider(height: 8),
            Spacer(),
            Text(
              'Amaan Zafar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Spacer(),
            Text(
              'BITS Pilani',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Github : amaan-zafar',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link),
                InkWell(
                  child: Text('profile-link'),
                  onTap: () => _launchURL(),
                ),
              ],
            ),
            Spacer(flex: 12),
            Text('Version 1.0'),
            Spacer(),
          ],
        )));
  }

  _launchURL() async {
    const url = 'https://github.com/amaan-zafar';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
