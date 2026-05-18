import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/color.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../data/repo/student_profile_repo.dart';
import '../view_models/profile_student_cubit.dart';
import '../view_models/profile_student_state.dart';

class DetailsStudentView extends StatelessWidget {
  const DetailsStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide a local ProfileCubit if one isn't available in the tree
    return BlocProvider<ProfileCubit>(
      create: (ctx) => ProfileCubit(
        StudentProfileRepo(
          DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAuthUrl),
        ),
      )..getProfile(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Details Student',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),

              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading || state is ProfileInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProfileFailure) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('Failed to load profile: ${state.error}'),
                    );
                  }

                  final profile = (state is ProfileSuccess)
                      ? state.profile
                      : null;

                  final image =
                      profile?.displayImage ?? 'assets/images/profile.png';
                  final name = profile?.fullName ?? '';
                  final phone = profile?.phoneNumber ?? '-';
                  final email = profile?.email ?? '-';
                  final department = profile?.departmentId ?? '-';
                  final studyGroup = '-';
                  final gender = '-';

                  return Column(
                    children: [
                      // Profile Image
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.primaryColor.withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: image.startsWith('http')
                                ? Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.person,
                                              size: 80,
                                              color: Colors.white,
                                            ),
                                  )
                                : Image.asset(
                                    image,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.person,
                                              size: 80,
                                              color: Colors.white,
                                            ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Student Information Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            _buildInfoCard(label: 'Name', value: name),
                            const SizedBox(height: 16),
                            _buildInfoCard(label: 'Phone', value: phone),
                            const SizedBox(height: 16),
                            _buildInfoCard(label: 'Email Id', value: email),
                            const SizedBox(height: 16),
                            _buildInfoCard(
                              label: 'Department',
                              value: department,
                            ),
                            const SizedBox(height: 16),
                            _buildInfoCard(
                              label: 'Study Group',
                              value: studyGroup,
                            ),
                            const SizedBox(height: 16),
                            _buildInfoCard(label: 'Gender', value: gender),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label :',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
