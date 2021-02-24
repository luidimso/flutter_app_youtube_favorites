import 'dart:convert';

import 'package:flutter_app_youtube_favorites/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyC1oiBaxRLPWeSDEmkQLG6BMEg8Cqwox0g";

class Youtube {
  search(String search) async {
    http.Response response = await http.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");
    decode(response);
  }

  List<Video> decode(http.Response response) {
    if(response.statusCode == 200) {
      var decoded = json.decode(response.body);
      List<Video> videos = decoded["items"].map<Video>(
          (map) {
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}