import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kawai/screens/favourite_screen.dart';
import 'package:kawai/screens/recent_screen.dart';
import 'package:kawai/utils/colors.dart';
import 'package:kawai/widgets/category_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int _activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      RecentScreen(),
      FavouriteScreen(),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: CustomColors().primeColor,
          toolbarHeight: 80,
          leadingWidth: 0,
          titleSpacing: 30,
          centerTitle: false,
          title: const Text(
            'KAWAI',
            style: TextStyle(fontFamily: 'Huballi', fontSize: 42),
            maxLines: 1,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 28,
                  color: CustomColors().primeColor,
                )),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SafeArea(
          child: Scaffold(
            body: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryWidget(
                    path: 'assets/images/recent_category.png',
                    title: 'RECENT',
                    activeIndex: _activeIndex,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CategoryWidget(
                    path: 'assets/images/favourite_category.png',
                    title: 'FAVOURITE',
                    activeIndex: _activeIndex,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: ScrollingDotsEffect(
                    activeStrokeWidth: 2.6,
                    activeDotScale: 1.3,
                    maxVisibleDots: 5,
                    radius: 10,
                    activeDotColor: CustomColors().secondaryColor,
                    dotColor: CustomColors().buttonColor,
                    spacing: 10,
                    dotHeight: 13,
                    dotWidth: 13,
                  )),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        _activeIndex = value;
                      });
                    },
                    itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index % pages.length];
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
