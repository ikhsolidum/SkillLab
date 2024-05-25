  import 'package:flutter/material.dart';
  import 'package:skilllab/pages/aboutus.dart';
  import 'package:skilllab/pages/login_page.dart';
  import 'package:skilllab/pages/userprofile.dart';
  import 'package:skilllab/sub_cat/subWood.dart';
  import 'package:skilllab/sub_cat/subMasonry.dart';
  import 'package:skilllab/sub_cat/subWeld.dart';
  import 'package:skilllab/sub_cat/subPot.dart';
  import 'package:skilllab/sub_cat/subCarpentry.dart';
  import 'package:skilllab/sub_cat/subAuto.dart';
  import 'package:skilllab/sub_cat/subCode.dart';
  import 'package:skilllab/pages/EnrolledCourses.dart';

  class SubjectState extends State<Subject> {
    String? _selectedItem;
    final List<String> _dropdownItems = ['Silay City', 'Bacolod City', 'Manapla'];
  


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(72, 92, 98, 1), // Darker color for the app bar
          title: const Text('S k i l l L a b'), // Add your app title here
        ),
        backgroundColor: const Color.fromRGBO(143, 166, 176, 1), // Lighter background color
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 150, // Adjust the height of the header as needed
                color: const Color.fromRGBO(72, 92, 98, 1), // Use the same color as app bar for consistency
                child: const Center(
                  child: Text(
                    'S k i l l L a b',
                    style: TextStyle(fontSize: 24, color: Colors.white), // Larger font size and white color for text
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.black87), // Icon color adjusted for better visibility
                title: const Text('Home', style: TextStyle(color: Colors.black87)), // Text color adjusted for better visibility
                onTap: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.book, color: Colors.black87), // Icon color adjusted for better visibility
                title: const Text('Enrolled Courses', style: TextStyle(color: Colors.black87)), // Text color adjusted for better visibility
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EnrolledCoursesPage(email: 'example@example.com')),
                    );
                    },
              ),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.black87), // Icon color adjusted for better visibility
                title: const Text('About Us', style: TextStyle(color: Colors.black87)), // Text color adjusted for better visibility
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.black87), // Icon color adjusted for better visibility
                title: const Text('Profile', style: TextStyle(color: Colors.black87)), // Text color adjusted for better visibility
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile(username: '', email: '')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.black87), // Icon color adjusted for better visibility
                title: const Text('Logout', style: TextStyle(color: Colors.black87)), // Text color adjusted for better visibility
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout Confirmation'),
                        content: Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Clear session data (optional)

                              // Navigate to the login page and remove all routes from the stack
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false, // Remove all routes
                              );
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 30.0,
            right: 30.0,
            bottom: 10.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select City',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  items: _dropdownItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Featured Courses',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: _buildSubjectContainers(context, _selectedItem),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtherCoursesPage(selectedCity: _selectedItem),
              ),
            );
          },
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Center(
              child: Text(
                'Other Courses',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    ),
  ),

      );
    }

    List<Widget> _buildSubjectContainers(
        BuildContext context, String? selectedCity) {
      List<Widget> containers = [];

      if (selectedCity == null) {
        return containers;
      }

      switch (selectedCity) {
        case 'Bacolod City':
          containers.add(_buildSubjectContainer(context, 'lib/images/woodwork.jpg',
              'Woodworking', SubWood()));
          containers.add(_buildSubjectContainer(context,
              'lib/images/automative.jpg', 'Automotive Repair', const SubAutomotive()));
          break;
        case 'Manapla':
          containers.add(_buildSubjectContainer(
              context, 'lib/images/weld.jpg', 'Welding', SubWeld()));
          containers.add(_buildSubjectContainer(context,
              'lib/images/carpentry.jpg', 'Carpentry', SubCarpentry()));
          break;
        case 'Silay City':
          containers.add(_buildSubjectContainer(
              context, 'lib/images/code.jpg', 'Coding', SubCoding()));
          containers.add(_buildSubjectContainer(
              context, 'lib/images/masonry.jpg', 'Masonry', SubMasonry()));
          containers.add(_buildSubjectContainer(
              context, 'lib/images/pottery.jpg', 'Pottery', SubPot()));
          break;
      }

      return containers;
    }

    Widget _buildSubjectContainer(
      BuildContext context, String imagePath, String subjectName, Widget subWidget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => subWidget),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.deepPurpleAccent,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8), // Add some spacing between the image and text
            Text(
              subjectName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Cen   ter the text
            ),
          ],
        ),
      ),
    );
  }
  }

  class Subject extends StatefulWidget {
    const Subject({Key? key, required String email}) : super(key: key);

    @override
    SubjectState createState() => SubjectState();
  }

  class OtherCoursesPage extends StatelessWidget {
    final String? selectedCity;

    const OtherCoursesPage({Key? key, required this.selectedCity}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Other Courses'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Courses Available'),
              SizedBox(height: 16.0),
              if (selectedCity != null) _buildCourseList(context),
              if (selectedCity == null)
                Text(
                  'Please select a city to see available courses.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    Widget _buildSectionTitle(String title) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget _buildCourseList(BuildContext context) {
      List<Widget> otherCourses = [];

      if (selectedCity != 'Bacolod City') {
        otherCourses.add(_buildCourseTile(
          context,
          'Automotive Repair',
          SubAutomotive(),
        ));
        otherCourses.add(_buildCourseTile(
          context,
          'Woodworking',
          SubWood(),
        ));
      }
      if (selectedCity != 'Manapla') {
        otherCourses.add(_buildCourseTile(
          context,
          'Welding',
          SubWeld(),
        ));
        otherCourses.add(_buildCourseTile(
          context,
          'Carpentry',
          SubCarpentry(),
        ));
      }
      if (selectedCity != 'Silay City') {
        otherCourses.add(_buildCourseTile(
          context,
          'Coding',
          SubCoding(),
        ));
        otherCourses.add(_buildCourseTile(
          context,
          'Masonry',
          SubMasonry(),
        ));
        otherCourses.add(_buildCourseTile(
          context,
          'Pottery',
          SubPot(),
        ));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: otherCourses,
      );
    }

    Widget _buildCourseTile(BuildContext context, String courseName, Widget courseWidget) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => courseWidget),
          );
        },
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              courseName,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

