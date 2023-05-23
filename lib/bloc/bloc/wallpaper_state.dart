part of 'wallpaper_bloc.dart';

class WallpaperState extends Equatable {
  final List<WallPaper> list;
  final List<WallPaper> favourite;
  final bool isLoading;
  final bool isError;
  const WallpaperState(
      {this.list = const [],
      this.favourite = const [],
      this.isLoading = false,
      this.isError = false});
  WallpaperState copyWith(
      {List<WallPaper>? list,
      List<WallPaper>? favourite,
      isLoading = false,
      isError = false}) {
    return WallpaperState(
        list: list == null ? this.list : [...this.list, ...list],
        favourite:
            favourite == null ? this.list : [...this.favourite, ...favourite],
        isLoading: isLoading,
        isError: isError);
  }

  @override
  List<Object?> get props => [list, favourite];
}
