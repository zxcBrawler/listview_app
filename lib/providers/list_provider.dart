import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listview_app/hive/notes.dart';

class ListProvider with ChangeNotifier {
  int selectedIndex = -1;

  List<Note> notes = [];

  void deleteNote(int index) async {
    if (index >= 0 && index < notes.length) {
      final box = await Hive.openBox<Note>('notesBox');
      final listItem = notes[index];
      box.delete(listItem.key);
      notes = box.values.toList();
      notifyListeners();
    }
  }

  void editNote(String newText) async {
    if (selectedIndex >= 0 && selectedIndex < notes.length) {
      final box = await Hive.openBox<Note>('notesBox');
      final listItem = notes[selectedIndex];
      listItem.text = newText;
      listItem.save();
      notes = box.values.toList();
      notifyListeners();
    }
  }

  void addNote(String text,
      {String? photoPath, double? latitude, double? longitude}) async {
    final box = await Hive.openBox<Note>('notesBox');
    final listItem = photoPath != null
        ? Note.withPhoto(text, photoPath,
            latitude: latitude, longitude: longitude)
        : Note(text);
    box.add(listItem);
    notes = box.values.toList().cast<Note>();
    notifyListeners();
  }

  void insertNote(int index, Note note) {
    notes.insert(index, note);
    notifyListeners();
  }
}
