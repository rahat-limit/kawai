import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:kawai/bloc/bloc/wallpaper_bloc.dart';
import 'package:kawai/models/wallpaper_model.dart';
import 'package:kawai/widgets/wallpaper_button.dart';

class WallPaperScreen extends StatefulWidget {
  final WallPaper wallpaper;
  const WallPaperScreen({super.key, required this.wallpaper});

  @override
  State<WallPaperScreen> createState() => _WallPaperScreenState();
}

class _WallPaperScreenState extends State<WallPaperScreen> {
  final bloc = WallpaperBloc();
  @override
  Widget build(BuildContext context) {
    Future<void> setWallpaper() async {
      int location = WallpaperManager.BOTH_SCREEN;
      var file =
          await DefaultCacheManager().getSingleFile(widget.wallpaper.path);

      await WallpaperManager.setWallpaperFromFile(file.path, location);
    }

    return Scaffold(
      body: Column(children: [
        Expanded(
            child: CachedNetworkImage(
          imageUrl: widget.wallpaper.path,
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
          imageBuilder: (context, imageProvider) {
            return Container(
              padding: const EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.wallpaper.path),
                      fit: BoxFit.cover)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WallPaperButton(
                          callback: () {
                            bloc.add(AddToFavouriteEvent(
                                wallpaper: widget.wallpaper));
                          },
                          icon: CupertinoIcons.heart,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        WallPaperButton(
                            callback: setWallpaper,
                            icon: Icons.wallpaper,
                            color: Colors.black),
                        const SizedBox(
                          width: 10,
                        ),
                        WallPaperButton(
                            callback: () {},
                            icon: Icons.share,
                            color: Colors.black),
                      ],
                    )
                  ]),
            );
          },
        )),
        // Container(
        //   margin: const EdgeInsets.only(bottom: 30),
        //   width: double.infinity,
        //   height: 60,
        //   color: Colors.yellow,
        // )
      ]),
    );
  }
}
