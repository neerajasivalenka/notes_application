import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_diary/notes_entry_model.dart';
import 'package:flutter_web_diary/notes_entry_page.dart';

class NotesEntryButton extends StatelessWidget {
  const NotesEntryButton({
    Key key,
    @required this.titleController,
    @required this.bodyTextController,
    @required this.widget,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyTextController;

  final NotesEntryPage widget;

  @override
  Widget build(BuildContext context) {
    final isAddAction = widget.notesAction == NotesAction.add;
    return FloatingActionButton.extended(
      elevation: 2,
      onPressed: () {
        final notesEntryMap = NotesEntry(
          title: titleController.text,
          body: bodyTextController.text,
        ).toMap();

        final id = widget.notesEntry.id;

        if (isAddAction) {
          FirebaseFirestore.instance.collection('data').add(notesEntryMap);
        } else {
          FirebaseFirestore.instance
              .collection('data')
              .doc(id)
              .update(notesEntryMap);
        }

        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      },
      label: Text(isAddAction ? 'Submit' : 'Update'),
      icon: Icon(isAddAction ? Icons.book : Icons.bookmark_border),
    );
  }
}
