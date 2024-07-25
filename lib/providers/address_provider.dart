import 'dart:developer';
import 'package:eat_easy/resources/data/database_service.dart';
import 'package:eat_easy/models/address.dart';
import 'package:eat_easy/models/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressProvider with ChangeNotifier {
  final List<models.Address> _addressesList = [];
  List<models.Address> get addressesList => _addressesList;

  int get length => addressesList.length;

  models.Address _selectedAddress = const Address(
    addressId: '',
    postalCode: '',
    addressType: '',
    address: '',
    // phone: '',
  );
  models.Address get selectedAddress => _selectedAddress;

  Future<void> addAddress(models.Address address, context) async {
    try {
      final addressesData = address.toMap();
      if (addressesData.isEmpty) {
        log('Addresses data is null ... ');
        throw Exception('Addresses data is null');
      }
      debugPrint(addressesData.toString());

      await DatabaseHelper.internal().saveAddress(address).then((value) {
        debugPrint("value $value");
        if (value != 0) {
          log('Address Added Successfully');
          _addressesList.add(address);
          Get.snackbar(
            'Saved!',
            'Address saved successfully ✔✨',
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
          );
          notifyListeners();
          Navigator.pop(context);
        }
      });

      notifyListeners();
    } catch (error) {
      log('Failed to add address: $error');
    }
  }

  Future<List<models.Address>> getAllAddress() async {
    try {
      await DatabaseHelper.internal().getAllAddress().then((value) {
        if (value.isNotEmpty) {
          _addressesList.clear();
          _addressesList.addAll(value);
        }
      });

      return _addressesList;
    } catch (error) {
      log('Failed to fetch addresses: $error');
      return [];
    }
  }

  Future<void> updateSelectedAddress(Address address) async {
    for (var element in _addressesList) {
      debugPrint("Before Selected Address $selectedAddress");

      if (element.addressId == address.addressId) {
        _selectedAddress = address;
        notifyListeners();
      }
    }
  }
}
