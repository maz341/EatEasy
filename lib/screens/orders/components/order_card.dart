import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_easy/models/order.dart';
import 'package:eat_easy/utils/constants.dart';
import 'package:eat_easy/utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(75),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://www.foodandwine.com/thmb/i0PF1kTaLedLZjlVTIAbrdD9Nag=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Best-US-Restaurants-for-Ambiance-Merois-FT-BLOG0423-072da39cb8104eb8b07d1f49c42f1dce.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "order #",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        order.orderId.substring(0, 8),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Text(
                    order.orderedDate.substring(0, 10),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: order.quantity.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                    fontSize: 12,
                                  ),
                          children: [
                            TextSpan(
                              text: " items",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$ ${order.amount}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Delivered",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       order.orderId,
        //       overflow: TextOverflow.ellipsis,
        //       style: const TextStyle(
        //         color: Colors.black,
        //         fontSize: 14,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       maxLines: 2,
        //     ),
        //     const SizedBox(height: 6),
        //     Text.rich(
        //       TextSpan(
        //         text: "\$${order.amount}",
        //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //               fontWeight: FontWeight.w600,
        //               color: kPrimaryColor,
        //             ),
        //         children: [
        //           TextSpan(
        //             text: " x",
        //             style: Theme.of(context).textTheme.bodyLarge,
        //           ),
        //           TextSpan(
        //             text: " 1 piece",
        //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //                   fontWeight: FontWeight.w600,
        //                   color: kTextColor,
        //                 ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // const Spacer(),
      ],
    );
  }
}
