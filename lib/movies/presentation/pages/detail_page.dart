// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../movie/domain/i_movie_repository.dart';
import '../../controllers/movie_detail_controller.dart';
import '../../core/constants.dart';
import '../components/chip_date.dart';
import '../components/error_warning.dart';
import '../components/rate.dart';
import '../components/trailer_button.dart';
import 'trailer_page.dart';

class DetailPage extends StatelessWidget {
  final int movieId;

  const DetailPage(this.movieId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(
      MovieDetailController(
        GetIt.I.get<IMovieRepository>(),
        movieId,
      ),
      tag: movieId.toString(),
    );

    return Scaffold(
      body: _controller.obx(
        (state) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            _buildAppBar(context, _controller),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGenresList(_controller),
                    _buildInfoRow(_controller, context),
                    _buildOverview(_controller, context),
                  ],
                ),
              ),
            ),
          ],
        ),
        onLoading: const Center(child: CircularProgressIndicator.adaptive()),
        onError: (error) => ErrorWarning(message: error.toString()),
      ),
    );
  }

  SliverAppBar _buildAppBar(
    BuildContext context,
    MovieDetailController _controller,
  ) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          Get.delete<MovieDetailController>(tag: movieId.toString());
        },
        icon: const Icon(Icons.arrow_back),
      ),
      expandedHeight: 220.0,
      floating: true,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        titlePadding: const EdgeInsets.all(8.0),
        title: Text(
          _controller.movieDetail.value?.title ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            letterSpacing: 1,
          ),
        ),
        background: _controller.movieDetail.value?.backdropPath != null
            ? Image.network(
                'https://image.tmdb.org/t/p/w500${_controller.movieDetail.value?.backdropPath}',
                fit: BoxFit.cover,
              )
            : Image.asset(
                kImagePlaceholderPath,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Row _buildGenresList(MovieDetailController _controller) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                if (_controller.movieDetail.value != null)
                  ..._controller.movieDetail.value!.genres!
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(
                            backgroundColor: const Color(0xFF492f59),
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
    );
  }

  Padding _buildOverview(
      MovieDetailController _controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _controller.movieDetail.value?.tagline?.toUpperCase() ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 8),
          Text(
            _controller.movieDetail.value?.overview ?? '',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Padding _buildInfoRow(
      MovieDetailController _controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateDisplay(date: _controller.movieDetail.value?.releaseDate),
              Row(
                children: [
                  TrailerButton(
                    movieId: movieId,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrailerPage(movieId),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Text(
                          '${_controller.movieDetail.value?.runtime.toString()} min')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
          Rating(_controller.movieDetail.value?.voteAverage),
        ],
      ),
    );
  }
}
