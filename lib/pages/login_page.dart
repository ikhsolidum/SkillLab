import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skilllab/pages/subject.dart';

class LoginPage extends StatefulWidget {
  static _LoginPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<_LoginPageState>();
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  String? _validateEmail(String value) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String value) {
    final RegExp passwordRegex = RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Min. 8 characters long, mix of upper/lowercase & numbers.';
    }
    return null;
  }

  void _showErrorDialog(String? message) {
    if (message != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _registerUser(String username, String email, String password) async {
    final url = Uri.parse('http://ikhsolidum.helioho.st/register.php'); // Update with your server URL

    String? emailError = _validateEmail(email);
    String? passwordError = _validatePassword(password);

    if (emailError != null) {
      _showErrorDialog(emailError);
      return;
    }

    if (passwordError != null) {
      _showErrorDialog(passwordError);
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
         
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Subject(email: email), // Your Subject page
            ),
          );
        } else {
          _showErrorDialog(responseData['message']);
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  Future<void> _loginUser(String email, String password) async {
    final url = Uri.parse('http://ikhsolidum.helioho.st/login.php');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
  
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Subject(email: email), // Navigate to the Subject page and pass the email
            ),
          );
        } else {
          _showErrorDialog(responseData['message']);
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _loginEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _loginPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String email = _loginEmailController.text;
                String password = _loginPasswordController.text;

                _loginUser(email, password);
              },
              child: Text('Login'),
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
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(72, 92, 98, 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipOval(
                  child: Image.asset(
                    'lib/images/skilllablogo.png',
                    fit: BoxFit.cover,
                    width: 200.0,
                    height: 340.0,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'SkillLab',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      Divider(color: Colors.grey[300]),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email),
                          errorText: _validateEmail(_emailController.text),
                        ),
                      ),
                      Divider(color: Colors.grey[300]),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock),
                          errorText: _validatePassword(_passwordController.text),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    if (_validateEmail(email) != null) {
                      _showErrorDialog(_validateEmail(email)!);
                    } else if (_validatePassword(password) != null) {
                      _showErrorDialog(_validatePassword(password)!);
                    } else {
                      _registerUser(username, email, password);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        _showLoginDialog();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
