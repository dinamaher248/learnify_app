import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:sizer/sizer.dart';

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
final VoidCallback? onTap;
final bool isDownloadedIcon ;
  const DetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isChecked,
    required this.onChanged,
    this.onTap,
    this.isDownloadedIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin:  EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.5.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.h),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF1A237E)),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  label,
                  style: AppStyles.style20SemiBold.copyWith(color: const Color(0xFF24234D)),
                ),
              ),
              isDownloadedIcon ? IconButton(onPressed: (){}, icon: const Icon(Icons.download)) 
              : Checkbox(
                value: isChecked,
                onChanged: onChanged,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}