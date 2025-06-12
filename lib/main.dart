import 'package:flutter/material.dart';
import 'home_page.dart'; // Đảm bảo import đúng file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(), // <- Đảm bảo class này tồn tại
      debugShowCheckedModeBanner: false,
    );
  }
}
