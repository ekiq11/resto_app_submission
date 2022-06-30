import 'package:flutter/material.dart';
import 'package:resto_app_submission/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resto_app_submission/data/preferences/preferences_helper.dart';
import 'package:resto_app_submission/common/style.dart';

class RestaurantSettingPage extends StatefulWidget {
  static const routeName = '/Setting';
  const RestaurantSettingPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSettingPage> createState() => _RestaurantSettingPageState();
}

class _RestaurantSettingPageState extends State<RestaurantSettingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 25,
                ),
              ),
            ),
          ),
          title: const Text('Setting'),
        ),
        body: ListTile(
          title: const Text('Schedule Notification'),
          trailing: Consumer<SchedulingProvider>(
            builder: (context, scheduled, _) {
              return Switch.adaptive(
                value: scheduled.isScheduled,
                onChanged: (value) async {
                  scheduled.enableDailyRestaurant(value);
                  scheduled.scheduledRestoApp(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
