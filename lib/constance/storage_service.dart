import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _preferences;
  static const String _selectedLanguageCodeKey = 'selected_language_code';
  static const String _sessionTokenKey = 'session_token';
  static const String _userId='user_id';
  static const String _role="role";
  static const String _userFirstName='userFirstName';
  static const String _userLastName='userLastName';
  static const String _userMobile='userMobile';
  static const String _userEmail='userEmail';

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save a String value
  static Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  /// Get a String value
  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  /// Save session token
  static Future<void> saveSessionToken(String token) async {
    await _preferences?.setString(_sessionTokenKey, token);
  }

  /// Get session token
  static String? getSessionToken() {
    return _preferences?.getString(_sessionTokenKey);
  }

  /// Remove session token
  static Future<void> removeSessionToken() async {
    await _preferences?.remove(_sessionTokenKey);
  }


    /// Save session token
  static Future<void> saveUserId(String userId) async {
    await _preferences?.setString(_userId, userId);
  }

  /// Get session token
  static String? getUserId() {
    return _preferences?.getString(_userId);
  }
  
  static Future<void> saveUserFirstName(String userFirstName) async{
   await _preferences?.setString(_userFirstName,userFirstName);
  }

  static String? getUserFirstName(){
    return _preferences?.getString(_userFirstName);
  }

   static Future<void> removeUserFirstName()async{
    await _preferences?.remove(_userFirstName);
  }

  static Future<void> saveUserLastName(String userLastName) async{
   await _preferences?.setString(_userLastName,userLastName);
  }

  static String? getUserLastName(){
    return _preferences?.getString(_userLastName);
  }

   static Future<void> removeUserLastName()async{
    await _preferences?.remove(_userLastName);
  }

    static Future<void> saveUserMobile(String userMobile) async{
   await _preferences?.setString(_userMobile,userMobile);
  }

  static String? getUserMobile(){
    return _preferences?.getString(_userMobile);
  }
  
  static Future<void> removeUserMobile()async{
    await _preferences?.remove(_userMobile);
  }

  static Future<void> saveUserEmail(String userEmail) async{
   await _preferences?.setString(_userEmail,userEmail);
  }

  static String? getUserEmail(){
    return _preferences?.getString(_userEmail);
  }
   
   static Future<void> removeUserEmail()async{
    await _preferences?.remove(_userEmail);
  }
      /// Save session token
  static Future<void> saveRole(String role) async {
    await _preferences?.setString(_role, role);
  }

  /// Get session token
  static String? getRole() {
    return _preferences?.getString(_role);
  }
 static Future<void> removeRle() async {
    await _preferences?.remove(_role);
  }
  /// Remove session token
  static Future<void> removeUser() async {
    await _preferences?.remove(_userId);
  }

  /// Save an Integer value
  static Future<void> saveInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  /// Get an Integer value
  static int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  /// Save a Boolean value
  static Future<void> saveBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  /// Get a Boolean value
  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  /// Save a Double value
  static Future<void> saveDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  /// Get a Double value
  static double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  /// Remove a specific key
  static Future<void> removeKey(String key) async {
    await _preferences?.remove(key);
  }

  /// Clear all saved data
  static Future<void> clear() async {
    await _preferences?.clear();
  }

  /// Save selected language code
  Future<void> setSelectedLanguageCode(String languageCode) async {
    await _preferences?.setString(_selectedLanguageCodeKey, languageCode);
  }

  /// Get selected language code
  Future<String?> getSelectedLanguageCode() async {
    return _preferences?.getString(_selectedLanguageCodeKey);
  }
}
