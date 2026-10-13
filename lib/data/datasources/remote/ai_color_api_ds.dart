/// Placeholder for a remote AI service. The app currently uses the
/// on-device `AiService`; plug an HTTP client in here if you add a backend.
class AiColorApiDs {
  Future<List<String>> fetchSuggestions(String hex) async => const [];
}
