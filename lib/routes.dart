import 'package:flutter/widgets.dart';
import 'package:friends_hch/screens/documents_screen.dart';
import 'package:friends_hch/screens/home_screen.dart';
import 'package:friends_hch/screens/login_screen.dart';
import 'package:friends_hch/screens/upload_document_screen.dart';
import 'package:friends_hch/screens/add_news_screen.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  'Home': (context) => HomeScreen(),
  'Login': (context) => const LoginScreen(),
  'Documents': (context) => DocumentsScreen(),
  'Upload Document': (context) => const UploadDocumentScreen(),
};
  'Add News': (context) => AddNewsScreen(),
