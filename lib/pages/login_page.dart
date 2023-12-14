import 'package:flutter/material.dart';
import 'package:listview_app/main.dart';
import 'package:listview_app/providers/list_provider.dart';
import 'package:listview_app/providers/settings_provider.dart';
import 'package:listview_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final ListProvider listProvider;
  const LoginPage({Key? key, required this.listProvider}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              color: Colors.cyan,
              onPressed: () => _submitCode(),
              child: const Text("submit code"),
            )
          ],
        ),
      )),
    );
  }

  void _submitCode() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var isDarkTheme = sp.getBool("darkTheme") ?? false;
    String enteredCode = _codeController.text;

    if (mounted) {
      final settings = Provider.of<SettingsProvider>(context, listen: false);
      if (enteredCode != settings.newLoginCode) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Wrong access code'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Builder(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<ListProvider>.value(
                    value: widget.listProvider,
                  ),
                  ChangeNotifierProvider<SettingsProvider>(
                    create: (context) => SettingsProvider(sp),
                    lazy: false,
                  ),
                  ChangeNotifierProvider<ThemeProvider>(
                      create: (_) => ThemeProvider(isDarkTheme))
                ],
                child: const MainPage(),
              ),
            ),
          ),
        );
      }
    }
  }
}
