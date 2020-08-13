import 'package:flutter/material.dart';
import 'package:notes/screens/note_list.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: NoteList(),
    );
  }
}
