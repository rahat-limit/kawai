import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kawai/screen_divider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .whenComplete(() {
    runApp(const ScreenDivider());
  });
}
