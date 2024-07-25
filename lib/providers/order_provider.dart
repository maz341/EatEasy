import 'dart:convert';
import 'dart:developer';
import 'package:eat_easy/models/order.dart';
import 'package:eat_easy/resources/data/database_service.dart';
import 'package:eat_easy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eat_easy/models/models.dart' as models;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OrderProvider with ChangeNotifier {


  Future addOrder({required models.Order order}) async {
    try {
      final orderData = order.toMap();
      if (orderData.isEmpty) {
        throw Exception('Order data is null');
      }

      await DatabaseHelper.internal().saveOrder(order).then((value) {
        if (value != 0) {
          // Order placed

          // Show Notification
          showLocalNotification(
            "10011",
            'Order Placed Successfully ✔🎉',
            'Your order is placed successfully',
            BigTextStyleInformation(
              'Your order of ${orderData['amount'] as double} is placed, \nestimated delivery within an hour.',
              htmlFormatBigText: true,
              contentTitle: 'Order Placed Successfully ✔🎉',
            ),
          );
        }
      });
    } catch (error) {
      log('Failed to add order: $error');
      throw Exception('Failed to add order: $error');
    }
  }

  // change orderCategory to Delivered
  Future<void> changeOrderStatus({
    required String uid,
    required String oid,
    required String orderStatus,
  }) async {}

  Future<List<models.Order>> getOrders() async {
    List<Order> modelList = [];
    debugPrint("GET ORDERS");
    await DatabaseHelper.internal().getAllOrders().then((value) {
      debugPrint("${jsonEncode(value)}\n_\n ");

      modelList.addAll(value);
    });

    return modelList;
  }
}
