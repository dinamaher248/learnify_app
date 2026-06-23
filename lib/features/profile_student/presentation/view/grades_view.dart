import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/color.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../data/repo/grades_repo.dart';
import '../view_models/grades_cubit.dart';
import '../view_models/grades_state.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GradesCubit>(
      create: (_) => GradesCubit(
        GradesRepo(DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl)),
      )..getGrades(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Grades',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<GradesCubit, GradesState>(
          builder: (context, state) {
            if (state is GradesLoading || state is GradesInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GradesFailure) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('Failed to load grades: ${state.error}'),
              );
            }

            final list = (state is GradesSuccess) ? state.grades : [];

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final course = list[index];
                return _buildGradeCard(
                  courseName: course.name,
                  instructorName: course.instructorName,
                  progress: course.completionPercentage,
                  courseImage: course.coverImageUrl ?? 'assets/images/lec1.png',
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 12),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGradeCard({
    required String courseName,
    required String instructorName,
    required int progress,
    required String courseImage,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Course Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              courseImage,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.book, color: Colors.white, size: 30),
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          // Course Info & Progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Name
                Text(
                  courseName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                // Instructor Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      onBackgroundImageError: (error, stackTrace) {},
                      child: const Icon(
                        Icons.person,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        instructorName,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$progress%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
