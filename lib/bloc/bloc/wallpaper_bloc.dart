import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kawai/models/wallpaper_model.dart';
import 'package:kawai/services/local_db.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

final Dio dio = Dio();
const String defaultPath =
    'https://harrynull.tech/api/wallpapers/random_anime_wallpaper';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(const WallpaperState()) {
    on<LoadWallpapersEvent>(
      _getWallpapers,
    );
    on<LoadWallpapersLocalDBEvent>(
      _getWallpapersFromDb,
    );
    on<AddToFavouriteEvent>(_addToFavorite);
    on<LoadFavouriteLocalDBEvent>(_loadFavouriteLocalDB);
  }

  _loadFavouriteLocalDB(event, emit) async {
    if (state.favourite.isEmpty) {
      emit(state.copyWith(isLoading: true));
      final List<WallPaper> favourite = await LocalStorage().getFavourite();
      emit(state.copyWith(favourite: favourite));
    }
  }

  _addToFavorite(
      AddToFavouriteEvent event, Emitter<WallpaperState> emit) async {
    WallPaper wallpaper = event.wallpaper;
    wallpaper.favourite = 1;
    // change in local db
    await LocalStorage().updateRow(wallpaper: event.wallpaper);
    // change in state
    emit(state.copyWith(favourite: [wallpaper]));
  }

  _getWallpapersFromDb(
      LoadWallpapersLocalDBEvent event, Emitter<WallpaperState> emit) async {
    try {
      final db = LocalStorage();
      emit(state.copyWith(isLoading: true));
      List<WallPaper> wallpapers = await db.getData();
      emit(state.copyWith(list: wallpapers));
    } catch (e) {
      emit(state.copyWith(isError: true));
      rethrow;
    }
  }

  _getWallpapers(
      LoadWallpapersEvent event, Emitter<WallpaperState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      print('update');
      List<WallPaper> list = [];
      for (int i = 0; i < 6; i++) {
        await dio.get(defaultPath).then((value) async {
          if (value.statusCode == 200) {
            await LocalStorage().insert(
                wallpaper:
                    WallPaper.fromJson(value.data as Map<String, dynamic>));
            list.add(WallPaper.fromJson(value.data as Map<String, dynamic>));
          }
        });
      }
      emit(state.copyWith(list: list));
    } catch (e) {
      emit(state.copyWith(isError: true));
      rethrow;
    }
  }
}
