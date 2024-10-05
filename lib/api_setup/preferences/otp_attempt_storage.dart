import 'package:shared_preferences/shared_preferences.dart';

class OtpAttemptStorage{
  final SharedPreferences _prefs;

  OtpAttemptStorage(this._prefs);

  Future<void> saveAttempts(int id) async {
    await _prefs.setInt('user_id', id);
  }

  Future<int?> getAttempts() async {
    return _prefs.getInt('user_id');
  }

  Future<void> clearAttempts() async {
    await _prefs.remove('user_id');
  }
}