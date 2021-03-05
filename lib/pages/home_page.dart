import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/components/video_component.dart';
import 'package:flutter_app_youtube_favorites/services/favorite_service.dart';
import 'package:flutter_app_youtube_favorites/services/search_service.dart';
import 'package:flutter_app_youtube_favorites/services/video_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoService = BlocProvider.of<VideoService>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/youtube-logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: BlocProvider.of<FavoriteService>(context).outFavorite,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Text("${snapshot.data.length}");
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: () {}
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: SearchService());
                if(result != null) videoService.inSearch.add(result);
              }
          )
        ],
      ),
      body: StreamBuilder(
        stream: videoService.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  if(index < snapshot.data.length) {
                    return VideoComponent(snapshot.data[index]);
                  } else if(index > 1){
                    videoService.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
