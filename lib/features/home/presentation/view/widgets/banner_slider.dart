import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:sizer/sizer.dart';

class BannerSlider extends StatefulWidget {
  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              bannerItem(),
              bannerItem(),
              bannerItem(),
              bannerItem(),
            ],
          ),

          Positioned(
            bottom: 10,
            child: Row(
              children: List.generate(4, (index) => buildDot(index)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 4.w,
      height: 4.w,
      decoration: BoxDecoration(
        color: currentIndex == index ? Color(0xff5047E4) : Color(0xffC6D1FB),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
  Widget bannerItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          AppAssets.image_home1,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}