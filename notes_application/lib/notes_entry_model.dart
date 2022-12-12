import 'package:cloud_firestore/cloud_firestore.dart';

class NotesEntry {
  final String title;
  final String body;
  final String id;

  NotesEntry({
    this.title,
    this.body,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory NotesEntry.fromDoc(QueryDocumentSnapshot doc) {
    return NotesEntry(
      title: doc.data()['title'],
      body: doc.data()['body'],
      id: doc.id,
    );
  }
}
