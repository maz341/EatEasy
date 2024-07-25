import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_easy/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:eat_easy/providers/providers.dart';
import 'package:eat_easy/utils/constants.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../utils/size_config.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle kPrimaryBoldTextStyle = TextStyle(
      fontSize: 18,
      color: kPrimaryColor,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.snackbar(
                'Under Development ℹ',
                'Feature is Under Development!',
                backgroundColor: kPrimaryColor,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Edit'),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                            ImagePath.avatarNetworkImage),
                        backgroundColor: kPrimaryColor,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Maaz Kamal',
                            style: kPrimaryBoldTextStyle,
                          ),
                          Text(
                            // 'authProvider.user.email'
                            'maaz.kom@gmail.com',
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: [
                      buildInfoRow(
                        context,
                        'Username',
                        // authProvider.user.username ??
                        'Maaz Kamal',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      buildInfoRow(
                        context,
                        'Phone number',
                        // authProvider.user.number ??
                        '+1 4372276755',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      buildInfoRow(
                        context,
                        'Gender',
                        // authProvider.user.gender ??
                        'Not Specified',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      buildInfoRow(context, 'Email', 'maaz.kom@gmail.com'
                          // authProvider.user.email,
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                color: kPrimaryColor.withOpacity(.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Center(
                                        child: Text(
                                          'Change Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: kPrimaryColor,
                                              ),
                                        ),
                                      ),
                                      content: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintStyle:
                                                const TextStyle(fontSize: 14),
                                            hintText: "Enter new password",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: const BorderSide(
                                                color: Colors.purple,
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 16,
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            suffixIcon: const CustomSurffixIcon(
                                              svgIcon: "assets/icons/Lock.svg",
                                            ),
                                          ),
                                          onChanged: (String newPassword) =>
                                              debugPrint("")
                                          ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Change'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                // padding 8
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                // decoration color kPrimary border radius 12
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Change password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildInfoRow(BuildContext context, String title, String value) {
    TextStyle kInfoTitleTextStyle = TextStyle(
      fontSize: 14,
      color: kPrimaryColor.withOpacity(.8),
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kInfoTitleTextStyle,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: kTextColor,
                ),
          ),
        ],
      ),
    );
  }
}
