import 'dart:io';

import 'package:dc_video_player/FilePickRoute.dart';
import 'package:dc_video_player/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoRoute extends StatefulWidget {
  static const routeName = '/VideoRoute';

  @override
  _VideoRouteState createState() => _VideoRouteState();
}

class _VideoRouteState extends State<VideoRoute> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void setVideo(path) {
    if (playerController == null) {
      playerController = VideoPlayerController.file(path)
        ..addListener(listener)
        ..setVolume(1.0)
        ..setLooping(true)
        ..initialize().then((_) {
          playerController.play();
        });
    }
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as FNArgument;
    setVideo(args.fPath);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(args.fName),
      ),
      body: VideoPlayerWidget(controller: playerController),
    );
  }
}
