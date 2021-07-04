extension TrimWhiteSpace on String {
  String stripWhiteSpace() {
    var noWhiteSpace;
    if (this.contains(" ")) {
      final wordList = this.split(" ");
      noWhiteSpace = wordList.join("");
    }

    return noWhiteSpace ?? this;
  }
}
