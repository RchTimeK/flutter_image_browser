import 'package:flutter/material.dart';
import 'package:flutter_image_browser/widgets/home_grid.dart';
import 'package:flutter_image_browser/widgets/home_image.dart';
import 'package:flutter_image_browser/widgets/home_video.dart';
import 'package:flutter_image_browser/widgets/image_drag.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: const HomeImagePage(),
      // home: const HomeVideoPage(),
       home: const HomeGridPage(),
    );
  }
}






