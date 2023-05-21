import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kawai/screens/home_screen.dart';
import 'package:kawai/screens/splash_screen.dart';
import 'package:kawai/utils/colors.dart';

class ScreenDivider extends StatelessWidget {
  const ScreenDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: CustomColors().scaffoldColor,
          textTheme: TextTheme(
            // ignore: deprecated_member_use
            headline1: TextStyle(
                color: CustomColors().primeColor, fontFamily: 'Mplus'),
            // ignore: deprecated_member_use
            headline2: TextStyle(
                color: CustomColors().primeColor, fontFamily: 'Mplus'),
            // ignore: deprecated_member_use
            bodyText2: TextStyle(
                color: CustomColors().primeColor, fontFamily: 'Mplus'),
            // ignore: deprecated_member_use
            subtitle1: TextStyle(
                color: CustomColors().primeColor, fontFamily: 'Mplus'),
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          )),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      home: const Center(child: CircularProgressIndicator()),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
