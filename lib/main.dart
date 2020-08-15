import 'package:flutter/material.dart';
import 'package:notes/screens/note_list.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color.fromARGB(255, 58, 149, 255);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData.light().copyWith(
        primaryColor: primaryColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          toggleableActiveColor: primaryColor,
          accentColor: primaryColor,
          buttonColor: primaryColor,
          textSelectionColor: primaryColor,
          textSelectionHandleColor: primaryColor),
      home: NoteList(),
    );
  }
}
