import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:sizer/sizer.dart';

class ChatAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.h,
      decoration: BoxDecoration(
        color: Color(0xFF5E5CE6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),

              const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/doctors.png',
                ), 
              ),
              Text(
                'Dr : Ehab Gamil',
                style: AppStyles.style20SemiBold.copyWith(
                  color: Color(0xffEFEDED),
                ),
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: const Icon(Icons.phone_outlined, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.videocam_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
