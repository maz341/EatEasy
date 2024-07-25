import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eat_easy/models/models.dart' as models;
import 'package:eat_easy/providers/address_provider.dart';
import 'package:eat_easy/screens/details/address/add_delivery_address.dart';
import 'package:eat_easy/screens/details/address/address_tile.dart';
import 'package:eat_easy/utils/constants.dart';

class DeliveryAddressesListScreen extends StatefulWidget {
  const DeliveryAddressesListScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressesListScreen> createState() =>
      _DeliveryAddressesListScreenState();
}

class _DeliveryAddressesListScreenState
    extends State<DeliveryAddressesListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar(BuildContext context) {
      return AppBar(
        title: Text(
          "Delivery Address",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: kPrimaryColor),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: kPrimaryColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          // Add address button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDeliveryAddress(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kPrimaryColor,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.house,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Add Location',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Addresses List
          Expanded(
            child: Consumer<AddressProvider>(
                builder: (context, addressProvider, child) {
              return FutureBuilder<List<models.Address>>(
                future: addressProvider.getAllAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    log('----------------------------------');
                    log(snapshot.error.toString());
                    log('----------------------------------');
                    return const Center(child: Text('Something went wrong'));
                  }

                  final List<models.Address> addressesList =
                      snapshot.data ?? [];
                  if (addressesList.isEmpty) {
                    log('----------------------------------');
                    log(snapshot.error.toString());
                    log('----------------------------------');
                    return const Center(
                      child: Text("No Address Found"),
                    );
                  }
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: addressesList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final addressItem = addressesList[index];
                      bool isAddressSelected = addressItem.addressId ==
                          addressProvider.selectedAddress.addressId;
                      return Row(
                        children: [
                          AddressTile(
                              addressModel: addressItem,
                              isSelected: isAddressSelected),
                        ],
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
