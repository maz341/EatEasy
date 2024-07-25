
import 'package:eat_easy/models/restaurants.dart';
import 'package:eat_easy/models/review.dart';
import 'package:eat_easy/screens/home/components/nearby_restaurants/restaurant_detail.dart';
import 'package:flutter/material.dart';
import '../../../../components/section_tile.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../loading/shimmer_box.dart';

class NearbyRestaurants extends StatefulWidget {
  const NearbyRestaurants({super.key});

  @override
  State<NearbyRestaurants> createState() => _NearbyRestaurantsState();
}

class _NearbyRestaurantsState extends State<NearbyRestaurants> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Restaurant>> fetchDataFromDB() async {
    final List<Restaurant> restaurantsList = [
      Restaurant(
        id: "123123123",
        name: 'Byblos Downtown',
        address: "11 Duncan St, Toronto, ON M5V 3M2",
        rating: 4.3,
        reviews: [
          Review(
            comment: "Amazing Ambience Restaurant",
            stars: 4.5,
            reviewerName: "Maaz Kamal",
            when: "2 days ago",
            isRecommend: false,
            reviewerPic: '',
          )
        ],
        description:
            "Luxe, 2-story restaurant putting a contemporary spin on Eastern Mediterranean cuisine & cocktails!",
        images: [
          'https://images.otstatic.com/prod/24898346/1/large.jpg',
          'https://media.blogto.com/listings/20181218-Byblos4.jpg?w=2048&cmd=resize_then_crop&height=1365&quality=70',
          'https://byblosdowntown.com/wp-content/uploads/2021/03/ByblosUT-5.jpg',
        ],
      ),
      Restaurant(
        id: "1233221",
        name: 'PAI',
        address: "18 Duncan St, Toronto, ON M5H 3G8",
        rating: 3.4,
        reviews: [
          Review(
            comment: "Amazing Ambience Restaurant",
            stars: 4.5,
            reviewerName: "Maaz Kamal",
            when: "2 days ago",
            isRecommend: false,
            reviewerPic: '',
          )
        ],
        description:
            "Nuit & Jeff Regular's casual Northern Thai spot serving dishes like salted crab & papaya salad!",
        images: [
          'https://axwwgrkdco.cloudimg.io/v7/__gmpics__/85d2e0e1b49447a5be36320c91994407',
          'https://res.cloudinary.com/scvr/image/upload/c_fit,f_auto,q_auto,w_1200/v1/restaurantion/gallery_photos/images/000/028/059/original/pai2.jpg',
        ],
      ),
    ];
    // final QuerySnapshot snapshot = await _refProducts.get();
    // for (var element in snapshot.docs) {
    //   final restaurantData = element.data() as Map<String, dynamic>;
    //   final List<dynamic> categories = restaurantData['categories'];
    //   if (categories.contains('NearbyRestaurants')) {
    //     restaurants.add(Product.fromMap(restaurantData));
    //   }
    // }
    return restaurantsList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SectionTitle(
            title: "Nearby Restaurants",
            press: () {

            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 20.0),
          child: FutureBuilder<List<Restaurant>>(
            future: fetchDataFromDB(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 200,
                  width: getProportionateScreenWidth(150),
                  child: ShimmerBox(
                    child: SizedBox(
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenWidth(150),
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              final List<Restaurant> restaurantsList = snapshot.data ?? [];

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurantsList.length,
                itemBuilder: (context, index) {
                  return NearbyRestaurantsCard(
                    image: restaurantsList[index].images.isNotEmpty
                        ? restaurantsList[index].images[0]
                        : '',
                    restaurant: restaurantsList[index],
                    category: "hello",
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class NearbyRestaurantsCard extends StatelessWidget {
  final Restaurant restaurant;
  final String? image;
  final String? category;
  const NearbyRestaurantsCard({
    super.key,
    required this.restaurant,
    this.image,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(
              restaurant: restaurant,
            ),
          ),
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: kPrimaryColor.withOpacity(.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 148,
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    image! == '' ? 'https://picsum.photos/250?image=9' : image!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        category! == '' ? 'NearbyRestaurants' : category!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
              child: Text(
                '\$ ${restaurant.address}',
                style: const TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
