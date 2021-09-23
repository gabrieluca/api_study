import 'package:api_study/controllers/trailer_controller.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

import 'dart:async';

class TrailerPage extends StatelessWidget {
  const TrailerPage(this.movieId, {Key? key}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(TrailerController(movieId));

    return Obx(
      () {
        return _controller.obx(
          (state) {
            return TrailerPlayer(movieId);
          },
          onLoading: const Center(child: CircularProgressIndicator.adaptive()),
          onError: (error) => Text(error.toString()),
        );
      },
    );
  }
}

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer(this.movieId, {Key? key}) : super(key: key);
  final int movieId;

  @override
  _TrailerPlayerState createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=$widget.movieId',
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _controller = Get.put(TrailerController(widget.movieId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
