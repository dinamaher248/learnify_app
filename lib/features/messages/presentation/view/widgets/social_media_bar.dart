import 'package:flutter/material.dart';

class SocialMediaBar extends StatelessWidget {
  const SocialMediaBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialIcon(assetPath: 'assets/images/Instagram.png'),
          SocialIcon(assetPath: 'assets/images/LinkedIn.png'),
          SocialIcon(assetPath: 'assets/images/X.png'),
          SocialIcon(assetPath: 'assets/images/Facebook.png'),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String assetPath;
  const SocialIcon({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath, width: 45, height: 45);
  }
}