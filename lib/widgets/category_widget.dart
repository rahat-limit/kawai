import 'package:flutter/material.dart';
import 'package:kawai/utils/colors.dart';

class CategoryWidget extends StatelessWidget {
  String title;
  String path;
  int activeIndex;

  CategoryWidget(
      {super.key,
      required this.title,
      required this.path,
      required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(path),
              width: 35,
              height: 35,
              fit: BoxFit.contain,
              color: title == 'RECENT'
                  ? activeIndex == 0
                      ? CustomColors().primeColor
                      : CustomColors().buttonColor
                  : activeIndex == 1
                      ? CustomColors().primeColor
                      : CustomColors().buttonColor,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(title)
          ]),
    );
  }
}
