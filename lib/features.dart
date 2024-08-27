import 'package:buddyai/color.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.title,
      required this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, bottom: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    color: MyColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color: MyColors.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
