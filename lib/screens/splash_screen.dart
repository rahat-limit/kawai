import 'package:flutter/material.dart';
import 'package:kawai/screens/home_screen.dart';
import 'package:kawai/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _checkFirst() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    // - to see intro screen
    bool check = pref.getBool('seen') ?? false;
    if (!check) {
      await pref.setBool('seen', true);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Image(
                  image: AssetImage('assets/images/intro_preview_image.png'))),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KAWAI',
                    style: TextStyle(fontFamily: 'Huballi', fontSize: 45),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Unlock the Anime World: Transform Your Screen with our Wallpaper App',
                    style: TextStyle(
                        fontSize: 18, color: CustomColors().textColor),
                  )
                ],
              )),
              const SizedBox(
                width: 10,
              ),
              const Image(
                image: AssetImage(
                  'assets/images/intro_flower.png',
                ),
                height: 90,
                width: 90,
                fit: BoxFit.contain,
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName),
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors().buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size.fromHeight(55), // NEW
            ),
            child: const Text(
              'Let`s Start!',
              style: TextStyle(fontSize: 19),
            ),
          )
        ],
      ),
    ));
  }
}
