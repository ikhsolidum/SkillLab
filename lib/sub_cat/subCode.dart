import 'package:flutter/material.dart';
import 'package:skilllab/pages/course.dart';
import 'package:skilllab/pages/enrolled_courses_provider.dart';
import 'package:provider/provider.dart';

class SubCoding extends StatelessWidget {
  SubCoding({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> persons = [
    {
      'name': 'Michael Francesze',
      'contactNumber': '555-123-4567',
      'location': '789 Oak Street, City',
      'email': 'michael.francesze@example.com',
    },
    {
      'name': 'Muhammad Ali',
      'contactNumber': '555-987-6543',
      'location': '321 Elm Avenue, Town',
      'email': 'muhammad.ali@example.com',
    },
    {
      'name': 'Manny Pacquiao',
      'contactNumber': '555-456-7890',
      'location': '456 Pine Road, Village',
      'email': 'manny.pacquiao@example.com',
    },
    {
      'name': 'Ryan Garcia',
      'contactNumber': '555-234-5678',
      'location': '987 Maple Lane, Hamlet',
      'email': 'ryan.garcia@example.com',
    },
    {
      'name': 'Damian Lillard',
      'contactNumber': '555-345-6789',
      'location': '654 Birch Street, County',
      'email': 'damian.lillard@example.com',
    },
  ];

  void showCourseOverview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Course Overview'),
          content: Text(
            'A coding course teaches students how to write computer programs and software applications using one or more programming languages. The course covers key programming concepts like data types, variables, control structures, functions, objects, file handling, and more. Both the theory behind programming and hands-on coding practice are included.',
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
            '1. Understanding of core programming principles and methodologies across multiple languages.\n\n'
            '2. Ability to write programs from scratch to solve problems or build applications.\n\n'
            '3. Experience with coding best practices like version control, debugging, testing.\n\n'
            '4. Familiarity with common data structures and algorithms.\n\n'
            '5. Exposure to code editors, IDEs, build tools and deployment environments.\n\n'
            '6. Basic comprehension of software development lifecycles and processes.\n\n'
            '7. Foundation to continue learning advanced programming topics or new languages.\n\n'
            '8. Coding portfolio with sample projects to demonstrate skills to potential employers.',
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
      title: const Text('Coding Course'),
      backgroundColor: const Color.fromRGBO(72, 92, 98, 1.0), // Changed alpha from 0 to 1
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
                    enrolledCoursesProvider.addCourse(Course('Coding'));
                    
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EnrolledCoursesProvider()),
      ],
      child: MaterialApp(
        home: SubCoding(),
      ),
    ),
  );
}
