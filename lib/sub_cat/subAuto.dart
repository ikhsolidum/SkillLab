import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skilllab/pages/course.dart';
import 'package:skilllab/pages/enrolled_courses_provider.dart';

class SubAutomotive extends StatelessWidget {
  const SubAutomotive({Key? key}) : super(key: key);

  void showCourseOverview(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Course Overview'),
        content: Text(
          'This course will focus on function, operation, and design of the mechanical aspects of modern automobiles.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showLearningOutcomes(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Learning Outcomes'),
        content: Text(
          'Identify the major parts of an automotive brake system, ​Explain the operating principles of steering systems., ​Perform fundamental electrical test.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> persons = [
      {
        'name': 'John Doe',
        'contactNumber': '123-456-7890',
        'location': '123 Main Street, City',
        'email': 'john.doe@example.com',
      },
      {
        'name': 'Jane Smith',
        'contactNumber': '987-654-3210',
        'location': '456 Oak Avenue, Town',
        'email': 'jane.smith@example.com',
      },
      // Add more persons with their details
    ]; // List of persons who offer the automotive course

    return Scaffold(
      appBar: AppBar(
        title: const Text('Automotive Course'),
        backgroundColor: const Color.fromRGBO(72, 92, 98, 0), // Transparent app bar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 500.0),
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListTile(
                      title: Text(
                        persons[index]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contact: ${persons[index]['contactNumber']}'),
                          Text('Location: ${persons[index]['location']}'),
                          Text('Email: ${persons[index]['email']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0), // Add vertical padding
          child: SingleChildScrollView( // Wrap the Row in a SingleChildScrollView
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      showCourseOverview(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      child: Text(
                        'Overview',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0), // Add spacing between buttons
                FittedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      showLearningOutcomes(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      child: Text(
                        'Outcomes',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0), // Add spacing between buttons
                FittedBox(
                  child: ElevatedButton(
                    onPressed: () {
                    final enrolledCoursesProvider = Provider.of<EnrolledCoursesProvider>(context, listen: false);
                    enrolledCoursesProvider.addCourse(Course('Automotive Repair'));
                    Navigator.pop(context);

                      // Show a Snackbar message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Course successfully added to Enrolled Courses'),
                          duration: Duration(seconds: 3), // Adjust the duration as per your preference
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}

class PersonDetailsPage extends StatelessWidget {
  final Map<String, dynamic> person;

  const PersonDetailsPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Contact Number: ${person['contactNumber']}'),
            ),
            ListTile(
              title: Text('Location: ${person['location']}'),
            ),
            ListTile(
              title: Text('Email: ${person['email']}'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SubAutomotive(),
  ));
}
