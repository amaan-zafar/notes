import 'package:flutter/material.dart';
import 'package:notes/theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const HomeAppBar({Key key, @required this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your notes',
                border: InputBorder.none,
              ),
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.grid_on), onPressed: (() {})),
            IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                onPressed: null),
          ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
