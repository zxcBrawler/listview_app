import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  SharedPreferences sp;
  TextEditingController nameController = TextEditingController();

  static const String name = 'fullName';
  static const String birthDate = 'birthDate';
  static const String code = 'loginCode';

  DateTime get newBirthDate {
    final dateString = sp.getString(birthDate);
    return dateString != null ? DateTime.parse(dateString) : DateTime.now();
  }

  set newBirthDate(DateTime value) {
    sp.setString(birthDate, value.toIso8601String());
    notifyListeners();
  }

  String get newLoginCode => sp.getString(code) ?? "1306";
  set newLoginCode(String value) {
    sp.setString(code, value);
    notifyListeners();
  }

  SettingsProvider(this.sp) {
    nameController.text = sp.getString(name) ?? '';
  }

  void updateName(String newName) {
    nameController.text = newName;
    sp.setString(name, newName);
    notifyListeners();
  }
}
