import 'package:api_study/core/constants.dart';
import 'package:flutter/material.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../controllers/movie_detail_controller.dart';
import '../widgets/error_warning.dart';
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
      return ErrorWarning(message: _controller.movieError!.message);
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
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGenreChips(),
                _buildStatus(),
                _buildOverview(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildGenreChips() {
    final _color = Color(0xFF492f59);
    return Material(
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (_controller.movieDetail != null)
                    ..._controller.movieDetail!.genres!
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Chip(
                              backgroundColor: _color,
                              // backgroundColor: Colors.purple[900],
                              label: Text(e.name),
                            ),
                          ),
                        )
                        .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChipDate(date: _controller.movieDetail?.releaseDate),

              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrailerPage(widget.movieId),
                      ),
                    ),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      // color: Color(0xFFffe796),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.play_arrow),
                            const SizedBox(width: 4),
                            const Text('Trailer'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Text('${_controller.movieDetail!.runtime.toString()} min')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              //TODO Rate stars
            ],
          ),
          Rate(_controller.movieDetail?.voteAverage),
        ],
      ),
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
}
