import 'package:api_study/core/constants.dart';
import 'package:flutter/material.dart';

import '../../controllers/movie_detail_controller.dart';
import '../widgets/error_handlers.dart';
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
    //TODO Hero cover transition
    //TODO Organize layout DetailPage
    //TODO Add fade in title

    return Scaffold(
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    if (_controller.loading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError!.message);
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 220.0,
          floating: true,
          pinned: true,
          snap: false,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            titlePadding: const EdgeInsets.all(8.0),
            title: Text(
              _controller.movieDetail?.title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            background: Hero(
              tag: widget.movieId,
              child: _controller.movieDetail?.backdropPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${_controller.movieDetail?.backdropPath}',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      kImagePlaceholderPath,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //TODO Fix horizontal scrolling
                _buildGenreChips(),
                _buildStatus(),
                _buildOverview(),
                _buildExtras(),
              ],
            ),
          ),
        ),
        if (_controller.movieDetail != null)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 75,
                  color: Colors.black12,
                ),
              ),
              childCount: 10,
            ),
          ),
      ],
    );
  }

  _buildOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _controller.movieDetail?.tagline?.toUpperCase() ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 8),
          Text(
            _controller.movieDetail?.overview ?? '',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  _buildStatus() {
    //TODO Create isReleased: Date info
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Rate(_controller.movieDetail?.voteAverage),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.hourglass_bottom),
                  const SizedBox(width: 8),
                  Text(_controller.movieDetail!.runtime.toString())
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrailerPage(widget.movieId),
              ),
            ),
            child: const Chip(
              label: Text('Trailer'),
              avatar: Icon(Icons.play_circle),
            ),
          ),
          ChipDate(date: _controller.movieDetail?.releaseDate),
        ],
      ),
    );
  }

  _buildExtras() {
    if (_controller.movieDetail != null) {
      return Column(
        children: [
          Text(_controller.movieDetail!.adult.toString()),
          Text(_controller.movieDetail!.status.toString()),
        ],
      );
    } else {
      return Container();
    }
  }

  _buildGenreChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          if (_controller.movieDetail != null)
            ..._controller.movieDetail!.genres!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(e.name),
                    ),
                  ),
                )
                .toList()
        ],
      ),
    );
  }
}
