import 'package:flutter/material.dart';
import 'package:flutter_web_diary/notes_entry_model.dart';
import 'package:flutter_web_diary/notes_entry_page.dart';
import 'package:flutter_web_diary/pop_up_menu.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    Key key,
    @required this.notesEntry,
  }) : super(key: key);

  final NotesEntry notesEntry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35.0),
      child: SizedBox(
        height: 250,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen.shade100,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                notesEntry.title,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              PopUpMenu(notesEntry: notesEntry)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              notesEntry.body,
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(height: 1.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return NotesEntryPage.read(
                                  notesEntry: notesEntry,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Read more',
                          style: TextStyle(
                            color: Colors.lightBlue.shade300,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
