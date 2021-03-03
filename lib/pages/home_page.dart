import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_youtube_favorites/components/video_component.dart';
import 'package:flutter_app_youtube_favorites/services/search_service.dart';
import 'package:flutter_app_youtube_favorites/services/video_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text("0"),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: () {}
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: SearchService());
                if(result != null) BlocProvider.of<VideoService>(context).inSearch.add(result);
              }
          )
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<VideoService>(context).outVideos,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return VideoComponent(snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
