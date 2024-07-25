import 'package:eat_easy/resources/images.dart';
import 'package:flutter/material.dart';
import '../../../../models/product.dart';
import '../../../../resources/data/static_data.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../loading/shimmer_box.dart';
import 'categories_card.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int curr = 0;

  List iconData = [
    ImagePath.burgerPath,
    ImagePath.pizzaPath,
    ImagePath.sandwichPath,
    ImagePath.spaghettiPath,
    ImagePath.drinkPath,
  ];

  List categoryText = [
    "Burgers",
    "Pizza",
    "Sandwich",
    "Spaghetti",
    "Drinks",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: iconData.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Product>> fetchDataFromDB(String category) async {
    final List<Product> listOfFood = foodList;
    return listOfFood;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(5),
        left: getProportionateScreenWidth(20),
        bottom: getProportionateScreenWidth(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                iconData.length,
                (index) => CategoryCard(
                  iconData: iconData[index],
                  text: categoryText[index],
                  press: () {
                    setState(() {
                      curr = index;
                    });
                  },
                  bgColor: curr == index ? kPrimaryColor : Colors.transparent,
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(15)),
          SizedBox(
            height: getProportionateScreenHeight(450),
            child: FutureBuilder<List<Product>>(
              future: fetchDataFromDB(categoryText[curr]),
              builder: (context, snapshot) {
                final List<Product> products = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: products.length < 4 ? products.length : 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
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
                    },
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (products.isEmpty) {
                  return const Center(
                    child: Text('No products found for the selected category'),
                  );
                }

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: products.length < 4 ? products.length : 4,
                  itemBuilder: (context, index) {
                    return CategoryGridItem(
                      product: products[index],
                      image: products[index].images.first,
                      category: products[index].categories.first,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
