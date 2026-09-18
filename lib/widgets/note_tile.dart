import 'package:flutter/material.dart';
import '../models/note.dart';
import '../screens/note_edit_screen.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  const NoteTile({required this.note});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context, listen: false);
    return Dismissible(
      key: ValueKey(note.id),
      background: Container(color: Colors.red, child: Icon(Icons.delete, color: Colors.white)),
      onDismissed: (_) async {
        if (note.id != null) await provider.deleteNote(note.id!);
      },
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NoteEditScreen(note: note))),
        trailing: IconButton(
          tooltip: 'Supprimer la note',
          icon: Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: note.id == null
              ? null
              : () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Supprimer la note ?'),
                      content: Text('Cette action est irréversible.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Annuler'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Supprimer'),
                        ),
                      ],
                    ),
                  );
                  if (shouldDelete == true) {
                    await provider.deleteNote(note.id!);
                  }
                },
        ),
      ),
    );
  }
}