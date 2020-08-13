import 'package:flutter/material.dart';
import 'package:notes/screens/note_detail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:notes/utils/database_helper.dart';
import 'package:notes/models/note.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Fab Pressed');
          navigateToDetail(Note('', '', 2), 'Add a note');
        },
        tooltip: 'Add a note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this.noteList[position].priority),
                child: getPriorityIcon(this.noteList[position].priority),
              ),
              title: Text(this.noteList[position].title),
              subtitle: Text(this.noteList[position].date),
              trailing: GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    _delete(context, noteList[position]);
                  }),
              onTap: () {
                debugPrint('ListTile tapped');
                navigateToDetail(this.noteList[position], 'Edit note');
              },
            ),
          );
        });
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note moved to trash');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String appBarTitle) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, appBarTitle);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() async {
    Database db = await dbHelper.initializeDatabase();
    List<Note> noteList = await dbHelper.getNoteList();
    setState(() {
      this.noteList = noteList;
      this.count = noteList.length;
    });
  }
}
