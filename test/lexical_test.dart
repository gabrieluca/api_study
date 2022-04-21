String merge(String inputFirst, String inputSecond) {
  String result = '';
  do {
    // print(inputFirst[i]);
    String first = inputFirst[0];
    String second = inputSecond[0];

//     print(first + second);
    if (first.toLowerCase().compareTo(second.toLowerCase()) == -1) {
      inputFirst = inputFirst.substring(1);
      result += first;
    } else if (first.toLowerCase().compareTo(second.toLowerCase()) == 1) {
      inputSecond = inputSecond.substring(1);
      result += second;
    } else {
      inputFirst = inputFirst.substring(1);
      inputSecond = inputSecond.substring(1);
      result += first;
    }

    print(result);
  } while (inputFirst.isNotEmpty && inputSecond.isNotEmpty);

  result += inputFirst;
  result += inputSecond;

  return result;
}

void main() {
  print('RESULT' + merge("super", "tower"));
  print('RESULT' + merge("super", "tower"));
  print('RESULT' + merge("super", "tower"));
  // print(merge("super", "tower"));
  // print(merge("super", "tower"));
}
