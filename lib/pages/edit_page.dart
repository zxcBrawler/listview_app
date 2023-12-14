import 'package:flutter/material.dart';
import 'package:listview_app/providers/list_provider.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final listProvider = Provider.of<ListProvider>(context, listen: false);
    _textController.text = listProvider.notes[listProvider.selectedIndex].text;
  }

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
                  listProvider.editNote(_textController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
