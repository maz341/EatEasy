import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eat_easy/models/models.dart' as models;
import 'package:eat_easy/providers/providers.dart';
import 'package:eat_easy/utils/size_config.dart';
import '../../loading/shimmer_box.dart';
import 'order_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: getProportionateScreenHeight(20),
        bottom: getProportionateScreenHeight(20),
      ),
      child: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return FutureBuilder<List<models.Order>>(
            future: orderProvider.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: getProportionateScreenHeight(15));
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: SizedBox(
                        height: getProportionateScreenHeight(120),
                        width: MediaQuery.of(context).size.width * .9,
                        child: ShimmerBox(
                          child: SizedBox(
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenWidth(100),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              if (snapshot.hasError) {
                debugPrint("snapshot has error ${snapshot.error.toString()}");
                return const Center(child: Text('Something went wrong'));
              }

              List<models.Order> orderList = snapshot.data ?? [];

              if (orderList.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }

              debugPrint("orderList ${orderList.length}");
              return ListView.separated(
                itemCount: orderList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: getProportionateScreenHeight(15));
                },
                itemBuilder: (context, index) {
                  final orderItem = orderList[index];
                  return OrderCard(order: orderItem);
                },
              );
            },
          );
        },
      ),
    );
  }
}
