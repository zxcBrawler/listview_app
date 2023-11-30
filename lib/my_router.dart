import 'package:flutter/material.dart';
import 'package:listview_app/pages/add_page.dart';
import 'package:listview_app/pages/edit_page.dart';
import 'package:listview_app/pages/home_page.dart';
import 'package:listview_app/constants.dart';

class MyRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case secondPage:
        return MaterialPageRoute(builder: (_) => AddPage());
      case thirdPage:
        return MaterialPageRoute(builder: (_) => const EditPage());
    }

    return MaterialPageRoute(
        builder: (context) => const Scaffold(body: Text('No route defined')));
  }
}
