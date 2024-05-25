import 'package:flutter/material.dart';
import 'course.dart';

class EnrolledCoursesProvider extends ChangeNotifier {
  List<Course> _enrolledCourses = [];

  List<Course> get enrolledCourses => _enrolledCourses;

  void addCourse(Course course) {
    _enrolledCourses.add(course);
    notifyListeners();
  }

  Map<String, dynamic> getCoursesData() {
    return {
      'courses': _enrolledCourses.map((course) => {
        'name': course.name,
      }).toList(),
    };
  }
}