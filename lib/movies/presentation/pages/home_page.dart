import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../movie/domain/i_movie_repository.dart';
import '../../controllers/home_controller.dart';
import '../components/error_warning.dart';
import '../components/home_app_bar.dart';
import '../components/movie_card.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.put(
    HomeController(
      GetIt.I.get<IMovieRepository>(),
    ),
  );
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _initScrollListener();
  }

  void _initScrollListener() => _scrollController.addListener(
        () async {
          if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent) {
            if (_controller.currentPage == _controller.lastPage.value) {
              _controller.lastPage.value++;
              await _controller.getAllMovies(_controller.lastPage.value);
              setState(() {});
            }
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        title: Text('Cinemagic'),
      ),
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: _controller.getAllMovies,
        child: _buildMovieGrid(),
      ),
    );
  }

  Column _buildMovieGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: const [
              Text(
                'Popular movies',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _controller.obx(
            (state) => GridView.builder(
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
            ),
            onLoading:
                const Center(child: CircularProgressIndicator.adaptive()),
            onError: (error) => ErrorWarning(message: error.toString()),
          ),
        ),
      ],
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
          ),
        ),
      ),
    );
  }
}
