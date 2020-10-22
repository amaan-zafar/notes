import 'package:flutter/material.dart';
import 'package:notes/screens/note_list.dart';
import 'package:notes/theme.dart';
import 'package:notes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NotesApp());
}

DarkThemeProvider themeChangeProvider = DarkThemeProvider();

void getCurrentAppTheme() async {
  themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getCurrentAppTheme();
    return ChangeNotifierProvider(
      create: (_) => themeChangeProvider,
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes',
            theme: AppTheme.themeData(themeChangeProvider.darkTheme, context),
            home: NoteList(),
          );
        },
      ),
    );
  }
}
