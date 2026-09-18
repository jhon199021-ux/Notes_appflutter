import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/db_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  /// Charger toutes les notes depuis la base
  Future<void> loadNotes() async {
    _notes = await DbHelper.instance.getNotes();
    notifyListeners();
  }

  /// Ajouter une nouvelle note
  Future<void> addNote(Note note) async {
    await DbHelper.instance.insertNote(note);
    await loadNotes(); // recharge la liste après ajout
  }

  /// Mettre à jour une note existante
  Future<void> updateNote(Note note) async {
    await DbHelper.instance.updateNote(note);
    await loadNotes();
  }

  /// Supprimer une note par son ID
  Future<void> deleteNote(int id) async {
    await DbHelper.instance.deleteNote(id);
    await loadNotes();
  }
}