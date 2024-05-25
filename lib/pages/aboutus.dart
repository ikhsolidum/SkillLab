import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'This application was created by Isaiah Kyle Solidum, Kevin RB De la Cruz, Kristina Mickaela Fujiwara, students from BS Information Technology 3A from the University of St. La Salle. The app connects passionate educators who want to share their expertise in their field for up-and-coming learners to use and hone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Meet the Team',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildProfileCard(
                context,
                'Isaiah Kyle Solidum',
                'Programmer',
                'isaiah.jpg', // Updated image path
                'God without man is God, but man without God is nothing.',
              ),
              SizedBox(height: 20),
              _buildProfileCard(
                context,
                'Kristina Mickaela Fujiwara',
                'Programmer',
                'fuj.jpg', // Updated image path
                'Always remember to live life to the fullest.',
              ),
              SizedBox(height: 20),
              _buildProfileCard(
                context,
                'Kevin RB De la Cruz',
                'Programmer',
                'kevin.png', // Updated image path
                'Remember that behind the dark clouds, the sun is still shining.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    String name,
    String occupation,
    String imagePath,
    String bio,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/images/$imagePath'), // Image path updated
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              occupation,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bio:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              bio,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
