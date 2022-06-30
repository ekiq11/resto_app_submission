import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:resto_app_submission/utils/date_time_helper.dart';
import 'package:resto_app_submission/utils/background_service.dart';
import 'package:resto_app_submission/data/preferences/preferences_helper.dart';
import 'package:flutter/foundation.dart';

class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreference();
  }
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyRestaurantPreference() async {
    _isScheduled = await preferencesHelper.isDailyNotifActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyNotif(value);
    scheduledRestoApp(value);
    _getDailyRestaurantPreference();
  }

  Future<bool> scheduledRestoApp(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      if (kDebugMode) {
        print('Scheduling Restaurant App Activated');
      }
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling Restaurant App Canceled');
      }
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
