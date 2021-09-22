abstract class MovieError implements Exception {
  late String message;

  @override
  String toString() {
    return message;
  }
}

class RepositoryError extends MovieError {
  RepositoryError(String message) {
    this.message = message;
  }
}
