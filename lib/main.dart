import 'package:flutter/material.dart';
import 'package:note_app/app/add.dart';
import 'package:note_app/app/auth/login.dart';
import 'package:note_app/app/auth/signup.dart';
import 'package:note_app/app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences sharedPref;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref=await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'note php rest',
    initialRoute:sharedPref.getString('id')==null? '/login':'/home',
    routes: {
      '/login':(context) => Login(),
      '/signup':(context) => SignUp(),
      '/home':(context) => Home(),
      '/addnote':(context) => AddNote(),
        },
    );
  }
}

