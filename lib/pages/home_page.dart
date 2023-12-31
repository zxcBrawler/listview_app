import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listview_app/utils/constants.dart';
import 'package:listview_app/hive/notes.dart';
import 'package:listview_app/providers/list_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, fourthPage);
                    },
                    icon: const Icon(Icons.settings)))
          ],
        ),
        body: Consumer<ListProvider>(builder: (context, listProvider, child) {
          return ReorderableListView.builder(
            itemCount: listProvider.notes.length,
            onReorder: ((oldIndex, newIndex) {
              final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
              final note = listProvider.notes.removeAt(oldIndex);
              listProvider.insertNote(index, note);
            }),
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (BuildContext context, int index) {
              final Note note = listProvider.notes[index];
              return ListTile(
                key: ValueKey(index),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(note.text),
                leading: note.photoPath != null
                    ? Image.file(File(note.photoPath!))
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.edit, color: Colors.cyan),
                        onPressed: () {
                          listProvider.selectedIndex = index;
                          Navigator.pushNamed(context, thirdPage,
                              arguments: index);
                        }),
                    IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          setState(() => showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Delete note $index?',
                                      textAlign: TextAlign.end,
                                    ),
                                    actions: [
                                      Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0)),
                                        color: Colors.cyan,
                                        child: MaterialButton(
                                            child: const Text('yes'),
                                            onPressed: () {
                                              setState(() {
                                                listProvider.deleteNote(index);
                                                Navigator.pop(context);
                                              });
                                            }),
                                      ),
                                      Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0)),
                                        color: Colors.cyan,
                                        child: MaterialButton(
                                            child: const Text('no'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      )
                                    ],
                                  );
                                },
                              ));
                        }),
                  ],
                ),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.cyan,
            onPressed: () => Navigator.pushNamed(context, secondPage),
            child: const Icon(Icons.add)),
      ),
    );
  }
}
