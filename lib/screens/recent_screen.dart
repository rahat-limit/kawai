import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kawai/bloc/bloc/wallpaper_bloc.dart';
import 'package:kawai/widgets/card_widget.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) context.read<WallpaperBloc>().add(LoadWallpapersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperBloc = WallpaperBloc()
      ..add(LoadWallpapersLocalDBEvent())
      ..add(LoadWallpapersEvent());

    return BlocBuilder<WallpaperBloc, WallpaperState>(
      bloc: wallpaperBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (state.isError) {
            return const SizedBox();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MasonryGridView.builder(
                  cacheExtent: 9999,
                  controller: _scrollController,
                  itemCount: state.list.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, item) {
                    return CardWidget(
                      wallpaper: state.list[item],
                    );
                  }),
            );
          }
        }
      },
    );
  }
}
