import 'package:flutter/material.dart';

class CenteredProgress extends StatelessWidget {
  const CenteredProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
