import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/assets.dart';

import '../../../../../../core/utils/color.dart';

/// A single lecture row.
///
/// Pass [showCheckbox] = true (e.g. Attendance Details screen) to show a
/// checkbox on the trailing edge. Leave false for a plain download-style row.
class LectureListItem extends StatelessWidget {
  final String title;
  final bool showCheckbox;
  final bool isChecked;
  final ValueChanged<bool?>? onCheckChanged;
  final String? imageUrl;

  const LectureListItem({
    super.key,
    required this.title,
    this.showCheckbox = false,
    this.isChecked = false,
    this.onCheckChanged,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetwork = imageUrl != null && imageUrl!.startsWith('http');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: isNetwork
                ? Image.network(
                    imageUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _fallback(),
                  )
                : _fallback(),
          ),
          const SizedBox(width: 12),

          // Label
          Expanded(
            child: Text(
              title,
              style: AppStyles.style16Medium.copyWith(
                color: const Color(0xFF24234D),
              ),
            ),
          ),

          // Trailing: checkbox or nothing
          if (showCheckbox)
            _StyledCheckbox(value: isChecked, onChanged: onCheckChanged)
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _fallback() => Image.asset(
        AppAssets.courses_image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
}

// ── Private checkbox widget ────────────────────────────────────────────────────

class _StyledCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const _StyledCheckbox({required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
    );
  }
}