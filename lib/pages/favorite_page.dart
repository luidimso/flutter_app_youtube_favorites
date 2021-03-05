import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/models/video.dart';
import 'package:flutter_app_youtube_favorites/services/favorite_service.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'api_page.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteService = BlocProvider.of<FavoriteService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: favoriteService.outFavorite,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((value) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY,
                      videoId: value.id
                  );
                },
                onLongPress: () {
                  favoriteService.toggleFavorite(value);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(value.thumb),
                    ),
                    Expanded(
                        child: Text(value.title,
                          style: TextStyle(
                            color: Colors.white70
                          ),
                        )
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
