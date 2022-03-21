abstract class Failure implements Exception {
  late final String message;

  @override
  String toString() {
    return message;
  }
}

class RequestFailure extends Failure {
  RequestFailure([String message = '']) {
    this.message = message;
  }
}

class ResponseFailure extends Failure {
  ResponseFailure([String message = '']) {
    this.message = message;
  }
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure([String message = 'UNAUTHORIZED 401']) {
    this.message = message;
  }
}

class CacheFailure extends Failure {
  CacheFailure([String message = '']) {
    this.message = message;
  }
}

class NetworkFailure extends Failure {
  NetworkFailure([String message = 'NO INTERNET CONNECTION']) {
    this.message = message;
  }
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure([String message = '']) {
    this.message = message;
  }
}
