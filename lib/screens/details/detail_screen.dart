import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailBody(product: product),
    );
  }
}
