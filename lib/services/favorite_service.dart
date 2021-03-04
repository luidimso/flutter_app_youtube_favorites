import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app_youtube_favorites/models/video.dart';

class FavoriteService implements BlocBase {
  Map<String, Video> _favorites = {};
  final StreamController<Map<String, Video>> _favoriteController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFavorite => _favoriteController.stream;

  @override
  void dispose() {
    _favoriteController.close();
  }

  void toggleFavorite(Video video) {
    if(_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favoriteController.sink.add(_favorites);
  }
}