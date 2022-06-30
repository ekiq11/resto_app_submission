import 'package:flutter/material.dart';
import '../data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyNotifPreferences();
    // _getTheme();
  }

  // bool _isDarkTheme = false;
  // bool get isDarkTheme => _isDarkTheme;

  bool _isDailyNotifActive = false;
  bool get isDailyNotifActive => _isDailyNotifActive;

  // void _getTheme() async {
  //   _isDarkTheme = await preferencesHelper.isDarkTheme;
  //   notifyListeners();
  // }

  void _getDailyNotifPreferences() async {
    _isDailyNotifActive = await preferencesHelper.isDailyNotifActive;
    notifyListeners();
  }

  // void enableDarkTheme(bool value) {
  //   preferencesHelper.setDarkTheme(value);
  //   _getTheme();
  // }

  void enableDailyNotif(bool value) {
    preferencesHelper.setDailyNotif(value);
    _getDailyNotifPreferences();
  }
}
