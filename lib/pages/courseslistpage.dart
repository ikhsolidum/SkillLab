import 'package:flutter/material.dart';
import 'package:skilllab/sub_cat/subCarpentry.dart';
import 'package:skilllab/sub_cat/subCode.dart';
import 'package:skilllab/sub_cat/subMasonry.dart';
import 'package:skilllab/sub_cat/subPot.dart';
import 'package:skilllab/sub_cat/subWeld.dart';
import 'package:skilllab/sub_cat/subWood.dart';
import 'package:skilllab/sub_cat/subauto.dart';

// Import the SubAutomotive widget
class CoursesListPage extends StatelessWidget {
  const CoursesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses List'),
      ),
      body: ListView.builder(
        itemCount: 7, // Number of courses
        itemBuilder: (context, index) {
          if (index == 0) {
            // If it's the first item, display SubAutomotive widget
            return ListTile(
              title: const Text('Automotive'), // Title for the first course
              subtitle: const Text('Description of Automotive course'), // Description for the first course
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SubAutomotive()),
                  // Navigate to SubAutomotive
                );
              },
            );
          } else if (index == 1) {
            // New course: carpentry
            return ListTile(
              title: const Text('Carpentry'),
              subtitle: const Text('Description of Carpentry course'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubCarpentry()),
                  
                );
                // Add navigation or action when Carpentry is tapped
              },
            );
          } else if (index == 2) {
            // New course: coding
            return ListTile(
              title: const Text('Coding'),
              subtitle: const Text('Description of Coding course'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubCoding()),
                  
                );
                // Add navigation or action when Coding is tapped
              },
            );
          } else if (index == 3) {
            // New course: masonry
            return ListTile(
              title: const Text('Masonry'),
              subtitle: const Text('Description of Masonry course'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubMasonry()),
                  // Navigate to SubAutomotive
                );
                // Add navigation or action when Masonry is tapped
              },
            );
          } else if (index == 4) {
            // New course: pottery
            return ListTile(
              title: const Text('Pottery'),
              subtitle: const Text('Description of Pottery course'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubPot()),
                  // Navigate to SubAutomotive
                );
                // Add navigation or action when Pottery is tapped
              },
            );
          } else if (index == 5) {
            // New course: welding
            return ListTile(
              title: const Text('Welding'),
              subtitle: const Text('Description of Welding course'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubWeld()),
                  // Navigate to SubAutomotive
                );
                // Add navigation or action when Welding is tapped
              },
            );
          } else if (index == 6) {
            // New course: woodworking
            return ListTile(
              title: const Text('Woodworking'),
              subtitle: const Text('Description of Woodworking course'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubWood()),
                  // Navigate to SubAutomotive
                );
                // Add navigation or action when Woodworking is tapped
              },
            );
          } else {
            // For other items, display placeholder text
            return ListTile(
              title: Text('Course ${index + 1}'), // Example course title
              subtitle: Text('Description of course ${index + 1}'), // Example course description
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SubAutomotive()),
                  // Navigate to SubAutomotive
                );
                // Add navigation or action when a course is tapped
              },
            );
          }
        },
      ),
    );
  }
}