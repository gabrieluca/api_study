void main() {
  bool solution(List<String> words, String variableName) {
    var result = true;

    for (var word in words) {
      final index = variableName.toLowerCase().indexOf(word);
      if (index != -1) {
        final possibleWord = variableName.substring(index, index + word.length);
        late final bool isPartCorrect;
        if (possibleWord.length > 1 && word.length > 1) {
          isPartCorrect = possibleWord.substring(2) == word.substring(2);
        } else {
          isPartCorrect = true;
        }
        final capitalLetter = possibleWord.substring(0, 1);
        var isFirstCorrect = capitalLetter.toLowerCase() != capitalLetter;
        if (index == 0) {
          isFirstCorrect = true;
        }
        if (!isPartCorrect || !isFirstCorrect) {
          result = false;
        }
      }
    }
    return result;
  }

  print('');
}
