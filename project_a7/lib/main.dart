import 'package:flutter/material.dart';
import 'package:project_a7/screen/home_screen.dart';
import 'package:project_a7/screen/permission_check_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PermissionCheckScreen(),
    ),
  );
}

