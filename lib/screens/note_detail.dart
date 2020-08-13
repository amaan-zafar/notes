import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/utils/database_helper.dart';
import 'package:notes/models/note.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  NoteDetail(this.note, this.appBarTitle);
  @override
  _NoteDetailState createState() =>
      _NoteDetailState(this.note, this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['High', 'Low'];

  DatabaseHelper dbHelper = DatabaseHelper();
  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: ListView(
            children: <Widget>[
              // Dropdown
              ListTile(
                  title: DropdownButton(
                items: _priorities.map((String dropDownItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownItem,
                    child: Text(dropDownItem),
                  );
                }).toList(),
                value: getPriorityAsString(note.priority),
                onChanged: (valueSelected) {
                  setState(() {
                    debugPrint('$valueSelected selected');
                    updatePriorityAsInt(valueSelected);
                  });
                },
              )),
              // Title TextField
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: TextField(
                  controller: titleController,
                  onChanged: (value) {
                    debugPrint('New value in title is $value');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              // Description TextField
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: TextField(
                  controller: descriptionController,
                  onChanged: (value) {
                    debugPrint('New value in description is $value');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              // Save and Delete buttons
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            debugPrint('Save clicked');
                            _save();
                          });
                        },
                        child: Text('Save'),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            debugPrint('Delete clicked');
                            _delete();
                          });
                        },
                        child: Text('Delete'),
                      )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await dbHelper.updateNote(note);
      debugPrint('New note');
    } else {
      result = await dbHelper.insertNote(note);
      debugPrint('Editing  note');
    }

    if (result != 0) {
      _showAlert('Status', 'Note saved successfully');
    } else {
      _showAlert('Status', 'Problem saving note');
    }
  }

  void _delete() async {
    moveToLastScreen();
    if (note.id == null) {
      _showAlert('Status', 'No note was deleted');
      return;
    }
    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlert('Status', 'Note deleted successfully');
    } else {
      _showAlert('Status', 'Error');
    }
  }

  void _showAlert(String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
