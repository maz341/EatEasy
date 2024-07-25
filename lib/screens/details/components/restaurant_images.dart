import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_easy/models/restaurants.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class RestaurantImages extends StatefulWidget {
  const RestaurantImages({
    Key? key,
    required this.restaurant
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  State<RestaurantImages> createState() => _RestaurantImagesState();
}

class _RestaurantImagesState extends State<RestaurantImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(width),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Hero(
                      tag: widget.restaurant.id.toString(),
                      child: PageView.builder(
                        itemCount: widget.restaurant.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: widget.restaurant.images[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 80,
                right: 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      widget.restaurant.images.length,
                      (index) => buildSmallProductPreview(index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(top: 10),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
          border: Border.all(
            width: selectedImage == index ? 2 : 0,
            color: Colors.white.withOpacity(selectedImage == index ? 1 : 0),
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.restaurant.images[index]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
