import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _tokenTypeKey = 'token_type';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _userFirstNameKey = 'user_first_name';
  static const String _userLastNameKey = 'user_last_name';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Token management
  Future<void> saveAccessToken(String token, String tokenType) async {
    await _prefs.setString(_accessTokenKey, token);
    await _prefs.setString(_tokenTypeKey, tokenType);
  }

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  String? getTokenType() {
    return _prefs.getString(_tokenTypeKey);
  }

  String? getUserFullName() {
    final firstName = _prefs.getString(_userFirstNameKey);
    final lastName = _prefs.getString(_userLastNameKey);
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return null;
  }


  String? getFullToken() {
    final token = getAccessToken();
    final type = getTokenType();
    if (token != null && type != null) {
      return '$type $token';
    }
    return null;
  }

  // User data
  Future<void> saveUserData({
    required String userId,
    required String email,
    required String firstName,
    required String lastName
  }) async {
    await _prefs.setString(_userIdKey, userId);
    await _prefs.setString(_userEmailKey, email);
    await _prefs.setString(_userFirstNameKey, firstName);
    await _prefs.setString(_userLastNameKey, lastName);
  }

  String? getUserId() => _prefs.getString(_userIdKey);
  String? getUserEmail() => _prefs.getString(_userEmailKey);
  String? getUserFirstName() => _prefs.getString(_userFirstNameKey);
  String? getUserLastName() => _prefs.getString(_userLastNameKey);

  // Clear all data (logout)
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return getAccessToken() != null;
  }
}