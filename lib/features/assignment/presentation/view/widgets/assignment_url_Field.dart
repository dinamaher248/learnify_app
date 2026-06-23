import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utils/app_styles.dart';

class AssignmentUrlField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSubmit;

  const AssignmentUrlField({super.key, this.controller, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
     width: double.infinity,
      height: 7.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2), 
        borderRadius: BorderRadius.circular(25), 
        border: Border.all(
          color: Color(0XFF6B6868), 
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
        decoration: InputDecoration(
          hintText: "Add Url Of Assignment",
          hintStyle:  AppStyles.style16Medium.copyWith(color: Color(0xff6B6868)),
          prefixIcon: const Icon(Icons.code, color: Color(0xff6B6868)),
          filled: true,
          fillColor: const Color(0xFFF5F5F5), 
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}