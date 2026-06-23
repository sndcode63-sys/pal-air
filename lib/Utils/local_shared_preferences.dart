import 'package:shared_preferences/shared_preferences.dart';

const loginKey = "LOGIN_STATUS";
const custAuthKey = "CUSTAUTHKEY";
const profileDataKey = "PROFILEDATAKEY";

class LocalPreferences {
  Future setLoginBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loginKey, value);
  }

  Future<bool?> getLoginBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginKey);
  }

  // ------------------------------------------------------------------

  Future setAuthToken(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(custAuthKey, val);
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(custAuthKey);
  }

  // ------------------------------------------------------------------

  Future setProfileData(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(profileDataKey, val);
  }

  Future<String?> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profileDataKey);
  }

  // ----------------------------------------------------------------------
}
