import 'package:api_study/core/constants.dart';
import 'package:flutter/material.dart';

import '../../controllers/movie_detail_controller.dart';
import '../widgets/centered_message.dart';
import '../widgets/centered_progress.dart';
import '../widgets/chip_date.dart';
import '../widgets/rate.dart';
import 'trailer_page.dart';

class DetailPage extends StatefulWidget {
  final int movieId;

  const DetailPage(this.movieId, {Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovieById(widget.movieId);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieDetail(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(_controller.movieDetail?.title ?? ''),
    );
  }

  _buildMovieDetail() {
    if (_controller.loading) {
      return const CenteredProgress();
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError!.message);
    }

    return ListView(
      children: [
        _buildCover(),
        _buildStatus(),
        _buildOverview(),
      ],
    );
  }

  _buildOverview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        _controller.movieDetail?.overview ?? '',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Rate(_controller.movieDetail?.voteAverage),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrailerPage(widget.movieId),
              ),
            ),
            icon: const Icon(Icons.ondemand_video),
          ),
          ChipDate(date: _controller.movieDetail?.releaseDate),
        ],
      ),
    );
  }

  _buildCover() {
    return Image.network(
      _controller.movieDetail?.backdropPath != null
          ? 'https://image.tmdb.org/t/p/w500${_controller.movieDetail?.backdropPath}'
          : coverPlaceholder,
    );
  }
}
