// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/18
// Description:
// -------------------------------------------------------------------
// Open the URL in a web browser.

class LinkModel {
  String title;
  String url;

  LinkModel(this.title, this.url);
}

List<LinkModel> getLatestLinkModels() {
  return [
    LinkModel("Flutter", "https://flutter.dev/"),
    LinkModel("Dart", "https://dart.dev/"),
    LinkModel(
      "Flutter SDK releases",
      "https://flutter.dev/docs/development/tools/sdk/releases",
    ),
    LinkModel("Dart SDK releases", "https://dart.dev/tools/sdk/releases"),
    LinkModel("Flutter API documentation", "https://api.flutter.dev/"),
    LinkModel(
      "Dart API documentation",
      "https://api.dart.dev/stable/2.15.0/dart-core/dart-core-library.html",
    ),
  ];
}
List<LinkModel> getRelatedLinkModels() {
  return [
    LinkModel("dart online compiler", "https://dart.dev/#try-dart"),
  ];
}
List<LinkModel> getAiLinkModels() {
  return [
    LinkModel("AI capcut", "https://www.capcut.com/"),
    LinkModel("AI claude", "https://claude.ai/new"),
    LinkModel("app.speechify", "https://app.speechify.com/?page=1"),
    LinkModel("AI notebooklm", "https://notebooklm.google.com/"),
    LinkModel("AI cursor", "https://www.cursor.com/ja"),
    LinkModel("openai", "https://openai.com/")

  ];
}
