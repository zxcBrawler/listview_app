import 'package:flutter/material.dart';
import 'package:listview_app/hive/boxes.dart';
import 'package:listview_app/hive/notes.dart';

class ListProvider with ChangeNotifier {
  final List<dynamic> list = notesBox.values.toList();

  int selectedIndex = -1;

  void insertNote(int index, String note) {
    list.insert(index, note);
    notifyListeners();
  }

  Future<void> addNote(String note) async {
    notesBox.add(note);
    notifyListeners();
  }

  Note getNote(int index) {
    return notesBox.getAt(index);
  }

  Future<void> editNote(String newText) async {
    notesBox.put(selectedIndex, newText); // fix
    notifyListeners();
  }

  Future<void> deleteNote(int index) async {
    notesBox.deleteAt(index);
    notifyListeners();
  }
}
