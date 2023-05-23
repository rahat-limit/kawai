part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}

class LoadWallpapersEvent extends WallpaperEvent {}

class LoadWallpapersLocalDBEvent extends WallpaperEvent {}

class LoadFavouriteLocalDBEvent extends WallpaperEvent {}

class AddToFavouriteEvent extends WallpaperEvent {
  final WallPaper wallpaper;
  AddToFavouriteEvent({required this.wallpaper});
}
