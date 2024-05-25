import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skilllab/pages/enrolled_courses_provider.dart';
import 'package:skilllab/pages/subject.dart';
import 'package:skilllab/pages/login_page.dart'; // Import the login page file

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EnrolledCoursesProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set LoginPage as the initial route
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), // LoginPage as the initial route
        '/subject': (context) => Subject(email: '',), // Subject page route
      },
    );
  }
}
