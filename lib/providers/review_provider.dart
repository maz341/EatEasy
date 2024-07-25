import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:eat_easy/models/models.dart' as models;

class ReviewProvider with ChangeNotifier {
  Future<List<models.Review>> getReviewsForProduct(String productId) async {
return [];
  }

  Future<void> addReviewToProduct(
      models.Review review, String productId) async {
    try {
      final reviewData = review.toMap();

      if (reviewData.isEmpty) {
        throw Exception('Review data is null');
      }


      notifyListeners();
    } catch (error) {
      log('Failed to add review to product: $error');
    }
  }
}
