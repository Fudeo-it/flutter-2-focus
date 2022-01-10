import 'package:flutter/material.dart';
import 'package:notes_app/database/notes_database.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final bool favorite;

  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final DismissDirectionCallback? onDismissed;

  const NoteWidget(
    this.note, {
    this.favorite = false,
    Key? key,
    this.onLongTap,
    this.onDismissed,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: Key(note.id.toString()),
        onDismissed: onDismissed,
        background: Container(color: Colors.red),
        child: ListTile(
          title: Text(note.title ?? note.content),
          subtitle: note.title != null ? Text(note.content) : null,
          onLongPress: onLongTap,
          trailing: Icon(
            favorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onTap: onTap,
        ),
      );
}
