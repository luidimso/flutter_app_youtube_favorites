import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/pages/api_page.dart';
import 'package:flutter_app_youtube_favorites/pages/home_page.dart';
import 'package:flutter_app_youtube_favorites/services/favorite_service.dart';
import 'package:flutter_app_youtube_favorites/services/video_service.dart';

void main() {
  Youtube api = Youtube();
  api.search("Flog Leap");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      bloc: VideoService(),
      child: BlocProvider(
        bloc: FavoriteService(),
        child: MaterialApp(
          title: "FlutterTube",
          home: HomePage(),
        ),
      )
    );
  }
}