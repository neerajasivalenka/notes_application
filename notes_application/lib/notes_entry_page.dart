import 'package:flutter/material.dart';
import 'package:flutter_web_diary/notes_entry_button.dart';
import 'package:flutter_web_diary/notes_entry_model.dart';

class NotesEntryPage extends StatefulWidget {
  const NotesEntryPage({
    Key key,
    this.notesAction,
    this.notesEntry,
  }) : super(key: key);

  const NotesEntryPage.edit(
      {Key key, this.notesAction = NotesAction.edit, this.notesEntry})
      : super(key: key);

  const NotesEntryPage.add(
      {Key key, this.notesAction = NotesAction.add, this.notesEntry})
      : super(key: key);

  const NotesEntryPage.read(
      {Key key, this.notesAction = NotesAction.read, this.notesEntry})
      : super(key: key);

  final NotesEntry notesEntry;

  final NotesAction notesAction;
  @override
  _NotesEntryPageState createState() => _NotesEntryPageState();
}

class _NotesEntryPageState extends State<NotesEntryPage> {
  TextEditingController titleController;
  TextEditingController bodyTextController;
  bool isReadOnly;
  @override
  void initState() {
    titleController =
        TextEditingController(text: widget.notesEntry?.title ?? '');
    bodyTextController =
        TextEditingController(text: widget.notesEntry?.body ?? '');
    isReadOnly = widget.notesAction == NotesAction.read;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),

                // Title
                TextField(
                  readOnly: isReadOnly,
                  controller: titleController,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black87),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: isReadOnly ? '' : 'Title',
                  ),
                ),
                // Body text
                TextField(
                  readOnly: isReadOnly,
                  controller: bodyTextController,
                  maxLines: null,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black87, height: 1.7),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Tell your notes what happened',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isReadOnly
          ? SizedBox()
          : NotesEntryButton(
              titleController: titleController,
              bodyTextController: bodyTextController,
              widget: widget,
            ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyTextController.dispose();
    super.dispose();
  }
}

enum NotesAction { edit, add, read }
