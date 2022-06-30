import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_submission/common/style.dart';
import 'package:resto_app_submission/data/api/api_service.dart';
import 'package:resto_app_submission/ui/restaurant_detail_page.dart';
import 'package:resto_app_submission/provider/resto_list_provider.dart';
import 'package:resto_app_submission/ui/restaurant_search_page.dart';
import 'package:resto_app_submission/widgets/card_list_restaurant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/Restaurant_List_Page';
  final String id;
  const RestaurantListPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoListProvider>(
      create: (_) =>
          RestoListProvider(listapiService: ApiService(http.Client()), id: ''),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(MdiIcons.magnifyExpand),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const RestaurantSearchPage()),
                  ),
                );
              },
            ),
          ],
          centerTitle: true,
          title: const Text(
            'Find My Resto',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: primaryColor,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  secondaryColor,
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Consumer<RestoListProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Memuat Data Restoran...',
                            style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result!.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result!.restaurants[index];
                    return CardListRestaurant(restaurant: restaurant);
                  },
                );
              } else if (state.state == ResultState.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.error) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}
