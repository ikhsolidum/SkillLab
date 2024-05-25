import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  final String username;
  final String email;

  UserProfile({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadProfileImage(int userId, File imageFile) async {
    final url = Uri.parse('https://ikhsolidum.helioho.st//upload_image.php');
    final request = http.MultipartRequest('POST', url);
    request.fields['userId'] = userId.toString();
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Profile image uploaded successfully');
    } else {
      print('Failed to upload profile image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: _pickImage,
                    )
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: _pickImage,
            ),
          ],
        ),
      ),
    );
  }
}