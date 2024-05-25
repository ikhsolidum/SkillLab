import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skilllab/pages/enrolled_courses_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Add this import for jsonEncode

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnrolledCoursesProvider(),
      child: MaterialApp(
        title: 'My App',
        home: EnrolledCoursesPage(email: 'example@email.com'),
      ),
    );
  }
}

class EnrolledCoursesPage extends StatefulWidget {
  final String email;

  EnrolledCoursesPage({Key? key, required this.email}) : super(key: key);

  @override
  _EnrolledCoursePageState createState() => _EnrolledCoursePageState();
}

class _EnrolledCoursePageState extends State<EnrolledCoursesPage> {
  late final EnrolledCoursesProvider enrolledCoursesProvider;

  @override
  void initState() {
    super.initState();
    enrolledCoursesProvider = context.read<EnrolledCoursesProvider>();
  }

  // Call this function when you need to send the data
  void _sendCoursesData() {
    sendCoursesData(enrolledCoursesProvider, widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final enrolledCoursesProvider = Provider.of<EnrolledCoursesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enrolled Courses',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 3, 3, 3)),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Enrolled Course/s',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: enrolledCoursesProvider.enrolledCourses.length,
                        itemBuilder: (context, index) {
                          final course = enrolledCoursesProvider.enrolledCourses[index];
                          return Text(
                            course.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black87),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}

Future<void> sendCoursesData(EnrolledCoursesProvider enrolledCoursesProvider, String email) async {
  final url = Uri.parse('https://ikhsolidum.helioho.st/courseslist.php');
  // Wrap the courses data inside a 'courses' key
  final coursesData = {
    'courses': enrolledCoursesProvider.getCoursesData(),
  };
  final body = jsonEncode(coursesData);

  print('Request body: $body');

  try {
    final response = await http.post(
      url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Courses data sent to server');
    } else {
      print('Failed to send courses data to server');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}
