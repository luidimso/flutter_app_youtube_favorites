import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/models/video.dart';

class VideoComponent extends StatelessWidget {
  final Video video;

  VideoComponent(this.video);

  @override
  Widget build(BuildContext context) {
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
              IconButton(
                  icon: Icon(Icons.star_border),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {}
              )
            ],
          )
        ],
      ),
    );
  }
}