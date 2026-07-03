import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tempTokenKey = 'temp_token';
  static const String _isLoggedInKey = 'is_logged_in';

  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==================== Access Token ====================
  static Future<void> saveAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
  }

  static String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  // ==================== Refresh Token ====================
  static Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  static String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

  // ==================== Temporary Token ====================
  static Future<void> saveTempToken(String token) async {
    await _prefs.setString(_tempTokenKey, token);
  }

  static String? getTempToken() {
    return _prefs.getString(_tempTokenKey);
  }

  // ==================== Login Status ====================
  static Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  static bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  // ==================== Utility Methods ====================

  /// Save all tokens at once (useful after login)
  static Future<void> saveAllTokens({
    required String accessToken,
    required String refreshToken,
    String? tempToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
      if (tempToken != null) saveTempToken(tempToken),
      setLoggedIn(true),
    ]);
  }

  /// Clear all tokens and logout
  static Future<void> logout() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
      _prefs.remove(_tempTokenKey),
      setLoggedIn(false),
    ]);
  }

  /// Check if user has valid access token
  static bool hasValidAccessToken() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear only temporary token
  static Future<void> clearTempToken() async {
    await _prefs.remove(_tempTokenKey);
  }
}
