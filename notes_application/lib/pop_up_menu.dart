import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_diary/notes_entry_model.dart';
import 'package:flutter_web_diary/notes_entry_page.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
    this.notesEntry,
  }) : super(key: key);
  final NotesEntry notesEntry;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
      elevation: 2,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Action.edit,
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: Action.delete,
            child: Text('Delete'),
          ),
        ];
      },
      onSelected: (action) {
        switch (action) {
          case Action.delete:
            _showDeleteDialog(context, onDelete: () {
              //TODO: 5. Create delete method with the doc id
              FirebaseFirestore.instance
                  .collection('data')
                  .doc(notesEntry.id)
                  .delete();
              Navigator.of(context).pop();
            });
            break;
          case Action.edit:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return NotesEntryPage.edit(
                    notesEntry: notesEntry,
                  );
                },
              ),
            );
            break;

          default:
        }
      },
    );
  }
}

enum Action { delete, edit, none }

void _showDeleteDialog(BuildContext context, {Function onDelete}) {
  showDialog(
    builder: (context) => AlertDialog(
      title: Text('Are you sure you want to delete?'),
      content: Text('Deleted note entries are permanent and not retrievable.'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: onDelete,
          child: Text('Delete'),
        )
      ],
    ),
    context: context,
  );
}
