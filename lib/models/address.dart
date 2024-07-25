class Address {
  final String addressId;
  final String postalCode;
  final String addressType;
  final String address;
  // final String phone;

  const Address({
    required this.addressId,
    required this.postalCode,
    required this.addressType,
    required this.address,
    // required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': addressId,
      'postal_code': postalCode,
      'type': addressType,
      'address': address,
      // 'phone': phone,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      addressId: map['id'] ?? '',
      postalCode: map['postal_code'] ?? '',
      addressType: map['type'] ?? '',
      address: map['address'] ?? '',
      // phone: map['phone'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Address.fromJson(String source) =>
  //     Address.fromMap(json.decode(source));

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json["id"],
        postalCode: json["postal_code"],
        addressType: json["type"],
        address: json["address"],
        // phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": addressId,
        "postal_code": postalCode,
        "type": addressType,
        "address": address,
        // "phone": phone,
      };
}
