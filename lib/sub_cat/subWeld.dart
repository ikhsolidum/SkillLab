import 'package:flutter/material.dart';

import 'package:skilllab/pages/course.dart';
import 'package:skilllab/pages/enrolled_courses_provider.dart';
import 'package:provider/provider.dart';

class SubWeld extends StatelessWidget {
  SubWeld({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> persons = [
    {
      'name': 'Klay Thompson',
      'contactNumber': '555-123-4567',
      'location': '789 Oak Street, City',
      'email': 'klay.thompson@example.com',
    },
    {
      'name': 'Lionel Messi',
      'contactNumber': '555-987-6543',
      'location': '321 Elm Avenue, Town',
      'email': 'lionel.messi@example.com',
    },
    {
      'name': 'Cristiano Ronaldo',
      'contactNumber': '555-456-7890',
      'location': '456 Pine Road, Village',
      'email': 'cristiano.ronaldo@example.com',
    },
    {
      'name': 'Karim Benzema',
      'contactNumber': '555-234-5678',
      'location': '987 Maple Lane, Hamlet',
      'email': 'karim.benzema@example.com',
    },
    {
      'name': 'Francis Ngannou',
      'contactNumber': '555-345-6789',
      'location': '654 Birch Street, County',
      'email': 'francis.ngannou@example.com',
    },
  ]; 

  void showCourseOverview(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Course Overview'),
        content: Text(
          'In this course students will be introduced to the various types of welding methods and equipment used. Students will learn about personal protection and safety while operating welding equipment. Students will also be introduced to two different types of thermal cutting using both plasma and oxy/fuel equipment. Also covered will be the many careers and positions that a successful welder may pursue and how to obtain a weld certification in the industry.',
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
          'Perform Shielded Metal Arc Welding (SMAW) on tee, lap, corner, and butt joints to trade specifications in the flat, horizontal, vertical, and overhead positions by: Following shop safety, personal protective equipment requirements for the task, and arc welding safety practices',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welding Course'),
        backgroundColor: const Color.fromRGBO(72, 92, 98, 0),
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
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListTile(
                      title: Text(
                        '${persons[index]['name']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Location: ${persons[index]['location']}'),
                          Text('Contact: ${persons[index]['contactNumber']} | Email: ${persons[index]['email']}'),
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
                    enrolledCoursesProvider.addCourse(Course('Welding'));
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
  runApp(MaterialApp(
    home: SubWeld(),
  ));
}
