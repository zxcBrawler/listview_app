import 'package:flutter/material.dart';
import 'package:listview_app/pages/login_page.dart';
import 'package:listview_app/utils/constants.dart';
import 'package:listview_app/hive/boxes.dart';
import 'package:listview_app/hive/notes.dart';
import 'package:listview_app/pages/home_page.dart';
import 'package:listview_app/providers/list_provider.dart';
import 'package:listview_app/utils/my_router.dart';
import 'package:listview_app/providers/settings_provider.dart';
import 'package:listview_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  notesBox = await Hive.openBox<Note>('notesBox');
  final SharedPreferences sp = await SharedPreferences.getInstance();
  var isDarkTheme = sp.getBool("darkTheme") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ListProvider>.value(value: ListProvider()),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(sp),
          lazy: false,
        ),
        ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(isDarkTheme))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(
          listProvider: ListProvider(),
        ),
      ),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, ThemeProvider value, Widget? child) {
        return MaterialApp(
          theme: value.getTheme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: MyRouter.generateRoute,
          title: 'Flutter ListView',
          initialRoute: homePage,
          home: const HomePage(),
        );
      },
    );
  }
}

//
