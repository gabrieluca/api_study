import 'package:api_study/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:api_study/controllers/movie_controller.dart';

import 'detail_page.dart';
import '../widgets/centered_message.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  //TODO Search Page
  //TODO Scroll Pagination
  //TODO Page title (inside scroll)
  // TODO Change to Getx
  // TODO Injectable

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = MovieController();
  final _scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _initialize();
  }

  _initScrollListener() {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (_controller.currentPage == lastPage) {
          lastPage++;
          await _controller.fetchAllMovies(page: lastPage);
          setState(() {});
        }
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchAllMovies(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        title: Text('Cinemagic'),
      ),
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: () => _initialize(),
        child: _buildMovieGrid(),
      ),
    );
  }

  _buildMovieGrid() {
    if (_controller.loading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError!.message);
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: _controller.moviesCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.6,
      ),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCard(
      movieId: movie.id.toString(),
      posterPath: movie.posterPath,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            movie.id!,
            movie.posterPath!,
          ),
        ),
      ),
    );
  }
}
