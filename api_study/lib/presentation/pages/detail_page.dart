import 'package:api_study/core/constants.dart';
import 'package:flutter/material.dart';

import '../../controllers/movie_detail_controller.dart';
import '../widgets/centered_message.dart';
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
    //TODO Icon row info
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    if (_controller.loading) {
      return const CircularProgressIndicator.adaptive();
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError!.message);
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
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
            background: Image.network(
              _controller.movieDetail?.backdropPath != null
                  ? 'https://image.tmdb.org/t/p/w500${_controller.movieDetail?.backdropPath}'
                  : coverPlaceholder,
              fit: BoxFit.cover,
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 75,
                      color: Colors.black12,
                    ),
                  ),
              childCount: 10),
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
            _controller.movieDetail?.tagline.toUpperCase() ?? '',
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

  _buildExtras() {
    if (_controller.movieDetail != null) {
      return Column(
        children: [
          Text(_controller.movieDetail!.adult.toString()),
          Text(_controller.movieDetail!.budget.toString()),
          Text(_controller.movieDetail!.status.toString()),
          Text(_controller.movieDetail!.releaseDate
              .toIso8601String()
              .toString()),
          Text('${_controller.movieDetail!.runtime.toString()} min'),
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
            ..._controller.movieDetail!.genres
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
