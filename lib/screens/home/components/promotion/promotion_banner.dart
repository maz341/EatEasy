import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../resources/data/static_data.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../splash/comonents/dot_indicator.dart';

class PromotionalBanner extends StatefulWidget {
  const PromotionalBanner({Key? key}) : super(key: key);

  @override
  State<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends State<PromotionalBanner> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            scrollDirection: Axis.horizontal,
            itemCount: promotionFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 200,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      promotionFoodList[index].imageUrl!,
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: getProportionateScreenWidth(300),
                      margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(5),
                        top: getProportionateScreenHeight(15),
                        bottom: getProportionateScreenHeight(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(15),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration:
                                const BoxDecoration(color: kSecondaryColor2),
                            child: Text(
                              promotionFoodList[index].label!.toUpperCase(),
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(13),
                                fontWeight: FontWeight.normal,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(7)),
                          Text(
                            promotionFoodList[index].name!.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  height: 1.0,
                                  fontSize: getProportionateScreenWidth(32),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(6)),
                          Text(
                            promotionFoodList[index]
                                .discountUpto!
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(10),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promotionFoodList.length,
            (index) => HorizontalDotIndicator(
              currentPage: currentPage,
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}
