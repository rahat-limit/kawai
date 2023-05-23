import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kawai/models/wallpaper_model.dart';
import 'package:kawai/screens/wallpaper_screen.dart';
import 'package:kawai/utils/colors.dart';

class CardWidget extends StatelessWidget {
  final WallPaper wallpaper;
  const CardWidget({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: wallpaper.path,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WallPaperScreen(
                      wallpaper: wallpaper,
                    )));
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            height: 320,
            decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                color: CustomColors().secondaryColor,
                borderRadius: BorderRadius.circular(15)),
          ),
        );
      },
      placeholder: (context, url) => Container(
        margin: const EdgeInsets.all(4),
        height: 200,
        child: const Center(
          child: Image(
            image: AssetImage('assets/images/cache_image.png'),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Image(
        image: AssetImage('assets/images/cache_image.png'),
      ),
    );
  }
}
