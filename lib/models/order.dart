class Order {
  final String orderId;
  // final String productId;
  final String productImage;
  final String orderedDate;
  final int quantity;
  final double amount;
  final String address;
  final String orderStatus;
  final String orderProducts;

  Order({
    required this.orderId,
    // required this.productId,
    required this.productImage,
    required this.orderedDate,
    required this.quantity,
    required this.amount,
    required this.address,
    required this.orderStatus,
    required this.orderProducts,
    // this.paymentInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': orderId,
      // 'productId': productId,
      'image': productImage,
      'date': orderedDate,
      'quantity': quantity,
      'amount': amount,
      'address': address,
      'status': orderStatus,
      'products': orderProducts,
      // 'paymentInfo': paymentInfo!.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      address: map['address'] ?? '',
      orderId: map['id'] ?? '',
      // productId: map['productId'] ?? '',
      productImage: map['image'] ?? '',
      orderedDate: map['date'] ?? DateTime.now().toString(),
      quantity: map['quantity']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      orderStatus: map['status'] ?? '',
      orderProducts: map['products'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["id"],
        // productId: json["productId"],
        productImage: json["image"],
        orderedDate: json["date"],
        quantity: json["quantity"],
        amount: json["amount"]?.toDouble(),
        address: json["address"],
        orderStatus: json["status"],
        orderProducts: json["products"],
      );

  Map<String, dynamic> toJson() => {
        "id": orderId,
        // "productId": productId,
        "image": productImage,
        "date": orderedDate,
        "quantity": quantity,
        "amount": amount,
        "address": address,
        "status": orderStatus,
        "products": orderProducts,
      };
}
