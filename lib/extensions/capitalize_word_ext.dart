extension WordCapitalize on String {
  String sentenceCase() => "${this[0].toUpperCase()}${this.substring(1)}";
}
