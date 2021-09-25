import 'package:api_study/controllers/trailer_controller.dart';
import 'package:api_study/presentation/widgets/error_handlers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPage extends StatelessWidget {
  const TrailerPage(this.movieId, {Key? key}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(TrailerController(movieId));

    return Obx(
      () {
        if (_controller.trailerUrl != null) {
          return _controller.obx(
            (state) => TrailerPlayer(_controller.trailerUrl!),
            onLoading:
                const Center(child: CircularProgressIndicator.adaptive()),
            onError: (error) => Text(error.toString()),
          );
        } else {
          return const CenteredLoading();
        }
      },
    );
  }
}

class TrailerPlayer extends StatelessWidget {
  const TrailerPlayer(this.trailerUrl, {Key? key}) : super(key: key);
  final String trailerUrl;

  @override
  Widget build(BuildContext context) {
    //TODO Fix to start the video
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: trailerUrl,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
            _controller.dispose();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Trailer'),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        bottomActions: [
          PlayPauseButton(),
        ],
        onEnded: (data) => data.toString(),
      ),
    );
  }
}
