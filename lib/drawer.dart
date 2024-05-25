import 'package:flutter/material.dart';
import 'package:skilllab/pages/subject.dart';

class Drawer extends StatelessWidget{
  const Drawer({Key? key, required child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Center(
              child: Text(
                'S k i l l L a b',
                style: TextStyle(fontSize: 20),
              ),
            )
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'Enrolled Courses'
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Subject(email: '',))
                  );
                },
            ),
          ],
        )
      )
    );
  }
}