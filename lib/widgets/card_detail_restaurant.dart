import 'package:flutter/material.dart';
import 'package:resto_app_submission/common/style.dart';
import '../data/model/restaurant_details.dart';
import '../widgets/card_drink_list.dart';
import '../widgets/card_food_list.dart';

class CardDetailRestaurant extends StatelessWidget {
  static const routeName = '/card_detail_restaurant';
  final Restaurant restaurant;
  const CardDetailRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              CircleAvatar(
                backgroundColor: primaryColor,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Container(
              margin: const EdgeInsets.all(8),
              color: primaryColor,
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Center(
                child: Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          pinned: true,
          backgroundColor: primaryColor,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              children: [
                Text(
                  restaurant.id,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.place,
                      size: 15,
                      color: secondaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      restaurant.city,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: secondaryColor,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${restaurant.rating}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.justify,
                ),
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Foods',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          CardFoodList(restaurant: restaurant),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Drinks',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          CardDrinkList(restaurant: restaurant),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
