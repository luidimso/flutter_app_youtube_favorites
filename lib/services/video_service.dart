import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app_youtube_favorites/models/video.dart';
import 'package:flutter_app_youtube_favorites/pages/api_page.dart';

class VideoService implements BlocBase {
  Youtube api;
  List<Video> videos;

  final StreamController _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final StreamController _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  VideoService() {
    api = Youtube();

    _searchController.stream.listen(_search);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  void _search(String search) async {
    api.search(search);
    print(videos);
  }
}