import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParentChildDetailView extends StatelessWidget {
  final Map<String, dynamic> childData;
  const ParentChildDetailView({super.key, required this.childData});

  @override
  Widget build(BuildContext context) {
    final id = childData['id']?.toString() ?? '';
    final name =
        '${childData['firstName'] ?? ''} ${childData['lastName'] ?? ''}';
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(
                '/parent-courses',
                extra: {'studentId': id, 'studentName': name},
              ),
              child: const Text('View Courses'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(
                '/parent-attendance',
                extra: {'studentId': id, 'studentName': name},
              ),
              child: const Text('View Attendance'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(
                '/parent-grades',
                extra: {'studentId': id, 'studentName': name},
              ),
              child: const Text('View Grades'),
            ),
          ],
        ),
      ),
    );
  }
}
