import 'package:shared_preferences/shared_preferences.dart';

class UserIdStorage{
  final SharedPreferences _prefs;

  UserIdStorage(this._prefs);

  Future<void> saveUserID(int id) async {
    await _prefs.setInt('user_id', id);
  }

  Future<int?> getUserID() async {
    return _prefs.getInt('user_id');
  }

  Future<void> clearUserID() async {
    await _prefs.remove('user_id');
  }
}