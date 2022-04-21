bool solution(String inputString) {
  final reversedString = inputString.split('').reversed.toList();
  if (reversedString.join() == inputString) {
    return true;
  } else {
    return false;
  }
}
