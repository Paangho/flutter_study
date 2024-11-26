import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage {
  // 데이터를 저장
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonTasks = tasks
        .map(
          (e) => jsonEncode({
            "title": e.title,
            "isCompleted": e.isCompleted,
            "priority": e.priority,
          }),
        )
        .toList();

    await prefs.setStringList('tasks', jsonTasks);
  }

  // 데이터를 불러오기
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonTasks = prefs.getStringList('tasks');

    if (jsonTasks == null) {
      return [];
    }

    return jsonTasks
        .map((e) => Task(
              title: jsonDecode(e)['title'],
              isCompleted: jsonDecode(e)['isCompleted'],
              priority: jsonDecode(e)['priority'],
            ))
        .toList();
  }
}
