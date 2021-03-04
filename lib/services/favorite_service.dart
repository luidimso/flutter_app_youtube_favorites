import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app_youtube_favorites/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService implements BlocBase {
  Map<String, Video> _favorites = {};
  final StreamController<Map<String, Video>> _favoriteController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFavorite => _favoriteController.stream;

  FavoriteService() {
    SharedPreferences.getInstance().then((value) {
      if(value.getKeys().contains("favorites")) {
        _favorites = json.decode(value.getString("favorites")).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();
        
        _favoriteController.add(_favorites);
      }
    });
  }

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
    _saveFavorite();
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((value) {
      value.setString("favorites", json.encode(_favorites));
    });
  }
}