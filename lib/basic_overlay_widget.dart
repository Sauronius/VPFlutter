import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onFullScreen;

  static const playbackSpeedValues = <double>[0.25, 0.5, 1, 1.25, 1.5, 2];

  const BasicOverlayWidget(
      {Key key, @required this.controller, this.onFullScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildSpeed(),
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(child: buildIndicator()),
                  const SizedBox(width: 12),
                  Row(
                        children: [
                          Icon(
                            controller.value.volume != 0
                                ? Icons.volume_up
                                : Icons.volume_off,
                            color: Colors.white,
                            size: 28,
                          ),
                            SliderTheme(data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                            ),
                            child: Container(
                              width: 110,
                            child: Slider(
                            value: controller.value.volume,
                            max: 1,
                            min: 0,
                            onChanged: (value) {
                              controller.setVolume(value);
                            }),
                            ),
                            ),
                            ]),
                  //
                  GestureDetector(
                    child: Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 28,
                    ),
                    onTap: onFullScreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => Container(
        margin: EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      );

  Widget buildSpeed() => Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<double>(
          initialValue: controller.value.playbackSpeed,
          tooltip: 'Playback speed',
          onSelected: controller.setPlaybackSpeed,
          itemBuilder: (context) => playbackSpeedValues
              .map<PopupMenuEntry<double>>((pbSpeed) =>
                  PopupMenuItem(value: pbSpeed, child: Text('$pbSpeed x')))
              .toList(),
          child: Container(
            color: Colors.white24,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text('${controller.value.playbackSpeed} x'),
          ),
        ),
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
        );
}
