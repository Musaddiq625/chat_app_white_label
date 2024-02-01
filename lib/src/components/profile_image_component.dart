import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImageComponent extends StatelessWidget {
  final String? url;
  final double size;
  final BoxFit fit;
  final bool isGroup;

  const ProfileImageComponent({
    Key? key,
    required this.url,
    this.size = 55.0,
    this.fit = BoxFit.cover,
    this.isGroup = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: url != null && url!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: url!,
              placeholder: (context, url) => Container(
                width: size,
                height: size,
                color: Colors.grey[200],
              ),
              errorWidget: (context, url, error) => Image.asset(
                isGroup ? AssetConstants.group : AssetConstants.profile,
                width: size,
                height: size,
                fit: fit,
              ),
              width: size,
              height: size,
              fit: fit,
              fadeInDuration:
                  const Duration(milliseconds: 500), // Adjust fade-in duration
              fadeOutDuration:
                  const Duration(milliseconds: 500), // Adjust fade-out duration
            )
          : Image.asset(
              isGroup ? AssetConstants.group : AssetConstants.profile,
              width: size,
              height: size,
              fit: fit,
            ),
    );
  }
}
