import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class CachedProgramImage extends StatelessWidget {
  final String imageUrl;

  const CachedProgramImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      memCacheHeight: 180,
      memCacheWidth: 300,
      placeholder: (context, url) => const ImagePlaceholder(),
      errorWidget: (context, url, error) => const ImagePlaceholder(),
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }
}
