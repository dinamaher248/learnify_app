import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructorName;
  final String instructorAvatar;
  final double progress; 

  const CourseCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.instructorName,
    required this.instructorAvatar,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170, 
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Course Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(imageUrl, height: 110, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          
          // Title
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1C3D)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Instructor Row
          Row(
            children: [
              CircleAvatar(radius: 14, backgroundImage: NetworkImage(instructorAvatar)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(instructorName, style: const TextStyle(color: Color(0xFF1A1C3D), fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Progress Bar
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE0E0E0),
                  color: const Color(0xFF5E5CE6),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text("${(progress * 100).toInt()}%", style: const TextStyle(color: Color(0xFF5E5CE6), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E5CE6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("View Lecture", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}