import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_submission/common/style.dart';
import 'package:resto_app_submission/ui/restaurant_detail_page.dart';
import 'package:resto_app_submission/ui/restaurant_favorite.dart';
import 'package:resto_app_submission/ui/restaurant_list_page.dart';
import 'package:resto_app_submission/ui/restaurant_setting_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/preferences/preferences_helper.dart';
import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';
import '../utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final screens = [
    RestaurantListPage(id: ''),
    RestaurantFavorite(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(
              preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          )),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        )
      ],
      child: const RestaurantSettingPage(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        MdiIcons.homeSearch,
        size: 30,
      ),
      const Icon(
        MdiIcons.heartMultiple,
        size: 30,
      ),
      const Icon(
        MdiIcons.cogs,
        size: 30,
      ),
    ];

    return Container(
      color: primaryColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          body: screens[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: primaryColor,
              buttonBackgroundColor: secondaryColor,
              height: 60,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 200),
              backgroundColor: Colors.transparent,
              index: index,
              onTap: (index) => setState(() => this.index = index),
              items: items,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
