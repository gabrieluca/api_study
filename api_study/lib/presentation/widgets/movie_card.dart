import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? posterPath;
  final void Function()? onTap;

  const MovieCard({
    Key? key,
    this.posterPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterUrl =
        'https://image.tmdb.org/t/p/w220_and_h330_face$posterPath';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(
              posterUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
