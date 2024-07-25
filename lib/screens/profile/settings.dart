import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationPermissionEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationPermissionStatus();
  }

  void _checkNotificationPermissionStatus() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationPermissionEnabled = status.isGranted;
    });
  }

  void _toggleNotificationPermission() async {
    if (!_notificationPermissionEnabled) {
      final status = await Permission.notification.request();
      setState(() {
        _notificationPermissionEnabled = status.isGranted;
      });
    } else {
      openAppSettings();
    }
  }

  Widget buildIOSSwitch() => Transform.scale(
        scale: 1.1,
        child: CupertinoSwitch(
          activeColor: kPrimaryColor.withOpacity(.5),
          trackColor: Colors.black,
          thumbColor: kPrimaryColor,
          value: _notificationPermissionEnabled,
          onChanged: (_) => _toggleNotificationPermission(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: kPrimaryColor),
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
            children: [
              // sized box 20
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          'Turn on & off notifications',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    // fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                    buildIOSSwitch(),
                  ],
                ),
              )
              ],
          ),
        ],
      ),
    );
  }
}
