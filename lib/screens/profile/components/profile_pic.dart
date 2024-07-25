import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_easy/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/constants.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
ImagePath.avatarNetworkImage
            ),
            backgroundColor: kPrimaryColor,
          ),
          Positioned(
            right: 5,
            bottom: -10,
            left: 75,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 23,
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 21,
                child: SvgPicture.asset(
                  "assets/icons/Camera Icon.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
