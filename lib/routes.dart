import 'package:flutter/widgets.dart';
import 'package:friends_hch/screens/documents_screen.dart';
import 'package:friends_hch/screens/home_screen.dart';
import 'package:friends_hch/screens/login_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  'Home': (context) => HomeScreen(),
  'Login': (context) => const LoginScreen(),
  'Documents': (context) => DocumentsScreen(),
};
