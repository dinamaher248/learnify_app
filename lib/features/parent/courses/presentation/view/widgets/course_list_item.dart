import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/assets.dart';

/// A reusable horizontal course card used in Courses, Grades, and Attendance screens.
///
/// Use [trailingWidget] to inject different trailing content per screen:
/// - Courses  → [ElevatedButton] "About Instructor"
/// - Grades   → progress bar + percentage text
/// - Attendance → [ElevatedButton] "View Attendance"
class CourseListItem extends StatelessWidget {
  final String title;
  final String instructorName;
  final String? imageUrl;
  final String? instructorAvatarUrl;
  final Widget trailingWidget;

  const CourseListItem({
    super.key,
    required this.title,
    required this.instructorName,
    required this.trailingWidget,
    this.imageUrl,
    this.instructorAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage =
        imageUrl != null && imageUrl!.startsWith('http');
    final bool isNetworkAvatar =
        instructorAvatarUrl != null && instructorAvatarUrl!.startsWith('http');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Top row: image + info ──────────────────────────────────
          Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: isNetworkImage
                    ? Image.network(
                        imageUrl!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _fallbackImage(),
                      )
                    : _fallbackImage(),
              ),
              const SizedBox(width: 12),

              // Title + instructor
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.style16Medium.copyWith(
                        color: const Color(0xFF24234D),
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: isNetworkAvatar
                              ? NetworkImage(instructorAvatarUrl!)
                              : const AssetImage(AppAssets.profile)
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            instructorName,
                            style: AppStyles.style14Regular.copyWith(
                              color: const Color(0xFF24234D),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Trailing widget (button / progress bar / etc.) ─────────
          trailingWidget,
        ],
      ),
    );
  }

  Widget _fallbackImage() => Image.asset(
        AppAssets.courses_image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
}