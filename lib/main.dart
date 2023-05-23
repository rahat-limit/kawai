import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawai/bloc/bloc/wallpaper_bloc.dart';
import 'package:kawai/screen_divider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .whenComplete(() {
    runApp(
      BlocProvider<WallpaperBloc>(
        create: (context) => WallpaperBloc(),
        child: const ScreenDivider(),
      ),
    );
  });
}
