import 'package:flutter/material.dart';
import 'package:listview_app/list_provider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _textController,
              ),
              MaterialButton(
                color: Colors.cyan,
                onPressed: () {
                  final listProvider =
                      Provider.of<ListProvider>(context, listen: false);
                  listProvider.addNote(_textController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
