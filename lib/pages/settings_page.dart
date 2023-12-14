import 'package:flutter/material.dart';
import 'package:listview_app/providers/settings_provider.dart';
import 'package:listview_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: settingsProvider.nameController,
                onChanged: (value) {
                  settingsProvider.updateName(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Choose date'),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: settingsProvider.newBirthDate,
                    firstDate: DateTime(1911),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    settingsProvider.newBirthDate = selectedDate;
                  }
                },
                controller: TextEditingController(
                    text: settingsProvider.newBirthDate
                        .toLocal()
                        .toString()
                        .split(' ')[0]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Secret code'),
                onChanged: (value) {
                  settingsProvider.newLoginCode = value;
                },
                controller:
                    TextEditingController(text: settingsProvider.newLoginCode),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.cyan,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .swapTheme();
                  },
                  child: const Text('Изменить тему'),
                ))
          ]),
        ),
      ),
    );
  }
}
