import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/pages/api_page.dart';
import 'package:flutter_app_youtube_favorites/pages/home_page.dart';

void main() {
  Youtube api = Youtube();
  api.search("Flog Leap");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "FlutterTube",
      home: HomePage(),
    );
  }
}