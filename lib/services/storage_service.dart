import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<List<String>> readStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return List<String>.from(prefs.getStringList(key) ?? const <String>[]);
  }

  Future<void> writeStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }
}
