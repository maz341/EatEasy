import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_easy/models/product.dart';
import 'package:eat_easy/screens/details/detail_screen.dart';
import 'package:eat_easy/utils/constants.dart';
import 'package:eat_easy/utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.icon,
    required this.text,
    required this.press,
    this.iconData,
    required this.bgColor,
  }) : super(key: key);

  final String? icon, text;
  // final IconData? iconData;
  final String? iconData;
  final Color bgColor;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          width: getProportionateScreenWidth(90),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor, width: 1),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(iconData!), height: 25),
                const SizedBox(height: 5),
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color:
                        bgColor != kPrimaryColor ? kPrimaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  final Product product;
  final String? image;
  final String? category;
  const CategoryGridItem({
    Key? key,
    required this.product,
    this.image,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        width: getProportionateScreenWidth(150),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kPrimaryColor.withOpacity(.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 130,
              // width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    image! == '' ? 'https://picsum.photos/250?image=9' : image!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 2, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.price}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: kPrimaryColor,
                        size: 12,
                      ),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
