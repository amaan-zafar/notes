import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/utils/database_helper.dart';
import 'package:notes/models/note.dart';

import '../utils.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  NoteDetail(this.note, this.appBarTitle);
  @override
  NoteDetailState createState() => NoteDetailState(this.note, this.appBarTitle);
}

class NoteDetailState extends State<NoteDetail> {
  static var _intToStringPriority = {1: 'High', 2: 'Low'};
  static var _stringToIntPriority = _intToStringPriority
      .map((k, v) => MapEntry(v, k)); //Reverses Key-Value pair

  DatabaseHelper dbHelper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

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
            automaticallyImplyLeading: false,
            title: Text(appBarTitle),
            // leading: IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () {
            //       moveToLastScreen();
            //     }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // Dropdown Button
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Priority :   ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: DropdownButton(
                          isExpanded: true,
                          items: _intToStringPriority.values
                              .map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Utils.getPriorityColor(
                                      _stringToIntPriority[dropDownStringItem]),
                                  child: Utils.getPriorityIcon(
                                      _stringToIntPriority[dropDownStringItem]),
                                ),
                                title: Text(dropDownStringItem),
                              ),
                            );
                          }).toList(),
                          value: _intToStringPriority[note.priority],
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              note.priority =
                                  _stringToIntPriority[valueSelectedByUser];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Title Textfield
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      debugPrint('New value = $value');

                      note.title = value;
                      debugPrint('New notes title = ${note.title}');
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Description Textfield
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    onChanged: (value) {
                      note.description = value;
                      debugPrint('New notes desc = ${this.note.description}');
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Save and Delete buttons
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
    debugPrint('Updated title is ${note.title}');
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
    debugPrint('Updated desc is ${note.description}');
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    debugPrint(
        'Saved: Title = ${note.title}, Description = ${note.description}, Date = ${note.date}');
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await dbHelper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await dbHelper.insertNote(note);
    }

    if (result == 0) {
      // Failure
      _showAlertDialog('Status', 'There was a problem saving your note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
