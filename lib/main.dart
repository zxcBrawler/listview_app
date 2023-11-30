import 'package:flutter/material.dart';
import 'package:listview_app/constants.dart';
import 'package:listview_app/hive/boxes.dart';
import 'package:listview_app/hive/notes.dart';
import 'package:listview_app/hive/user.dart';
import 'package:listview_app/pages/home_page.dart';
import 'package:listview_app/list_provider.dart';
import 'package:listview_app/my_router.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(NoteAdapter());
  userBox = await Hive.openBox<User>('userBox');
  notesBox = await Hive.openBox<User>('notesBox');
  runApp(ChangeNotifierProvider<ListProvider>.value(
    value: ListProvider(),
    child: const MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouter.generateRoute,
      title: 'Flutter ListView',
      initialRoute: homePage,
      home: HomePage(),
    );
  }
}

//
