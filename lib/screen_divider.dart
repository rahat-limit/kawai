import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenDivider extends StatelessWidget {
  const ScreenDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      )),
      debugShowCheckedModeBanner: false,
      home: const Center(child: CircularProgressIndicator()),
    );
  }
}
