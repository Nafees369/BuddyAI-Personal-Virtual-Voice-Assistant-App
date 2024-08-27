import 'package:buddyai/color.dart';
import 'package:flutter/material.dart';
import 'package:buddyai/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuddyAI',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: MyColors.whiteColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: MyColors.whiteColor,
          )),
      home: const HomePage(),
    );
  }
}
