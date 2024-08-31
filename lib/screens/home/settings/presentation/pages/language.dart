class Language {
  final String title;
  final String code;

  const Language({
    required this.title,
    required this.code,
  });
}

final languageList = [
  const Language(title: "English", code: "en"),
  const Language(title: "German", code: "de"),
  const Language(title: "Turkish", code: "tr"),
];