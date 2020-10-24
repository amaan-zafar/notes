import 'package:flutter/material.dart';
import 'package:notes/components/header.dart';
import 'package:notes/components/home_app_bar.dart';
import 'package:notes/components/navigation_drawer.dart';
import 'package:notes/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notes/utils/database_helper.dart';
import 'package:notes/models/note.dart';

import '../utils.dart';
import 'about.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  bool darkTheme = true;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(
          height: 80,
        ),
        drawer: NavigationDrawer(),
        body: count == 0 ? emptyScreen() : getNoteListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToDetail(Note('', '', 2), 'Add a note');
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          final Note noteItem = noteList[position];
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: Dismissible(
              key: Key(noteItem.id.toString()),
              onDismissed: (direction) {
                _delete(context, noteItem);
              },
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Utils.getPriorityColor(this.noteList[position].priority),
                  child:
                      Utils.getPriorityIcon(this.noteList[position].priority),
                ),
                title: Text(this.noteList[position].title),
                subtitle: Text(this.noteList[position].description),
                onTap: () {
                  navigateToDetail(this.noteList[position], 'Edit Your Note');
                },
              ),
            ),
          );
        });
  }

  Container emptyScreen() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
            child: Icon(
          Icons.note_add,
          size: 120,
          color: Colors.blue,
        )),
        Text(
          'Notes you add appear here',
          textScaleFactor: 1.1,
        ),
      ],
    ));
  }

  void _delete(BuildContext context, Note note) async {
    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, note, 'Note moved to trash');
      updateListView();
    }
  }

  void _undoDelete(Note note) async {
    setState(() async {
      await dbHelper.insertNote(note);
    });
  }

  void _showSnackBar(BuildContext context, Note note, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => _undoDelete(note),
      ),
    );
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
