import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';

class AttendanceDialog extends StatelessWidget {
  const AttendanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,//Color(0xffF2F2F2).withOpacity(0.3),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // QR Code Placeholder
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white),
              child: Image.network(
                'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Example',
                height: 150,
              ),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Code: ",
                    style: AppStyles.style24SemiBold.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "19700",
                    style: AppStyles.style24SemiBold.copyWith(
                      color: Color(0xFF5047E4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Your Code",
                hintStyle: AppStyles.style16Medium.copyWith(
                  color: Color(0xff6B6868),
                ),
                prefixIcon: const Icon(Icons.code, color: Color(0xff6B6868)),
                filled: true,
                fillColor: const Color(0xFFC6D1FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
