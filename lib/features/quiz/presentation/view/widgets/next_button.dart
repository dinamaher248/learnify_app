import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_styles.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onTap,
    this.onBackTap,
    this.isBackEnabled = false,
  });

  final VoidCallback onTap;
  final VoidCallback? onBackTap;
  final bool isBackEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Row(
          children: [
            isBackEnabled
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(40.w, 8.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: onBackTap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              "Back",
                              style: AppStyles.style20SemiBold.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(40.w, 8.h),

                  backgroundColor: const Color(0xFF5047E4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: AppStyles.style20SemiBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
