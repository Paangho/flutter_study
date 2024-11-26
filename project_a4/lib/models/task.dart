import 'package:flutter/material.dart';

class Task {
  String title;
  bool isCompleted;
  int priority;

  Task({
    required this.title,
    this.isCompleted = false,
    this.priority = 2,
  });
}