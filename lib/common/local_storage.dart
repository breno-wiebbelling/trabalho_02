import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

    SharedPreferences? _prefs;

    Future<void> _initiatePrefs() async {
        _prefs = await SharedPreferences.getInstance();
    }

    Future<String> getObject( String key ) async {
        await _initiatePrefs();

        return _prefs?.getString(key) ?? "";
    }

    Future<void> setObject( String key, String object ) async {
        await _initiatePrefs();
    
        await _prefs?.setString(key, object);
    }
}