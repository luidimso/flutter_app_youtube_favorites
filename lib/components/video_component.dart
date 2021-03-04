import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/models/video.dart';
import 'package:flutter_app_youtube_favorites/services/favorite_service.dart';

class VideoComponent extends StatelessWidget {
  final Video video;

  VideoComponent(this.video);

  @override
  Widget build(BuildContext context) {
    final favoriteService = BlocProvider.of<FavoriteService>(context);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network(video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(video.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(video.channel,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),
                        ),
                      )
                    ],
                  )
              ),
              StreamBuilder<Map<String, Video>>(
                stream: favoriteService.outFavorite,
                initialData: {},
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          favoriteService.toggleFavorite(video);
                        }
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              )
            ],
          )
        ],
      ),
    );
  }
}
