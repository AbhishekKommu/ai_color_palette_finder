class Validators {
  static final RegExp _hex = RegExp(r'^#?([0-9a-fA-F]{6})$');

  static bool isValidHex(String value) => _hex.hasMatch(value.trim());
}
