class Language {
  final int id;
  final String flag;
  final String name;
  final String code;

  Language(this.id, this.flag, this.name, this.code);

  static List<Language> languageList() {
    return [
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇻🇳", "Tiếng Việt", "vi"),
      Language(3, "🇰🇷", "한국어", "ko"),
      Language(4, "🇨🇳", "中文", "cn"),
      Language(5, "🇩🇪", "Deutsch", "de"),
      Language(6, "🇦🇹", "Deutsch (Austria)", "de_AT"),
      Language(7, "🇬🇷", "Ελληνικά", "el"),
      Language(8, "🇪🇸", "Español", "es"),
      Language(9, "🇫🇷", "Français", "fr"),
      Language(10, "🇭🇷", "Hrvatski", "hr"),
      Language(11, "🇭🇺", "Magyar", "hu"),
      Language(12, "🇮🇹", "Italiano", "it"),
      Language(13, "🇯🇵", "日本語", "jp"),
      Language(14, "🇳🇱", "Nederlands", "nl"),
      Language(15, "🇵🇱", "Polski", "pl"),
      Language(16, "🇧🇷", "Português (Brazil)", "ptBR"),
      Language(17, "🇷🇴", "Română", "ro"),
      Language(18, "🇷🇺", "Русский", "ru"),
      Language(19, "🇹🇷", "Türkçe", "tr"),
    ];
  }
}
