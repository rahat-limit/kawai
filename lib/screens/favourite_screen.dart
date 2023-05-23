import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kawai/bloc/bloc/wallpaper_bloc.dart';
import 'package:kawai/widgets/card_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = WallpaperBloc()..add(LoadFavouriteLocalDBEvent());
    return BlocBuilder<WallpaperBloc, WallpaperState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MasonryGridView.builder(
                itemCount: state.favourite.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, item) {
                  return CardWidget(
                    wallpaper: state.favourite[item],
                  );
                }));
      },
    );
  }
}
