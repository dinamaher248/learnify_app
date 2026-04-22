import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';

class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            "$label : ",
            style:AppStyles.style20SemiBold,
          ),
          Text(
            value,
            style: AppStyles.style16Medium,
          ),
        ],
      ),
    );
  }
}