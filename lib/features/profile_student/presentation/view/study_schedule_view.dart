import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/color.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../../home/schedule/data/repo/schedule_repo.dart';
import '../../../home/schedule/presentation/view/schedule_section.dart';
import '../../../home/schedule/presentation/view_models/schedule_cubit.dart';
import '../../../home/schedule/presentation/view_models/schedule_state.dart';

class StudyScheduleView extends StatelessWidget {
  const StudyScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (_) =>
          ScheduleCubit(
              ScheduleRepo(
                DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl),
              ),
            )
            ..loadAllSchedules(),
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
            'Study Schedule',
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
              const SizedBox(height: 24),
              // Other static content follows
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'Class Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    BlocBuilder<ScheduleCubit, ScheduleState>(
                      builder: (context, state) {
                        if (state is ScheduleLoading ||
                            state is ScheduleInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ScheduleFailure) {
                          return Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              'Failed to load schedule: ${state.message}',
                            ),
                          );
                        }

                        final list = (state is ScheduleLoaded)
                            ? state.schedules
                            : [];

                        if (list.isEmpty) {
                          return const SizedBox();
                        }

                        final imageUrl = list.first.imageUrl;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (_) => Scaffold(
                                  backgroundColor: Colors.black,
                                  appBar: AppBar(
                                    backgroundColor: Colors.black,
                                    iconTheme: const IconThemeData(
                                      color: Colors.white,
                                    ),
                                  ),
                                  body: Center(
                                    child: InteractiveViewer(
                                      minScale: 0.5,
                                      maxScale: 4,
                                      child: Hero(
                                        tag: 'class_schedule',
                                        child: buildImage(imageUrl),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'class_schedule',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: buildImage(imageUrl),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'Midterm Exam Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Midterm schedule loaded from API
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 220,
                          child: BlocBuilder<ScheduleCubit, ScheduleState>(
                            builder: (context, state)
                             {
                              if (state is ScheduleLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is ScheduleLoaded) {
                                if (state.midterms.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'the midterm schedule is not exist yet',
                                    ),
                                  );
                                }
                                final imageUrl = state.midterms.first.imageUrl;

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => Scaffold(
                                          backgroundColor: Colors.black,
                                          appBar: AppBar(
                                            backgroundColor: Colors.black,
                                            iconTheme: const IconThemeData(
                                              color: Colors.white,
                                            ),
                                          ),
                                          body: Center(
                                            child: InteractiveViewer(
                                              minScale: 0.5,
                                              maxScale: 4,
                                              child: Hero(
                                                tag: 'midterm_schedule',
                                                child: buildImage(imageUrl),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'midterm_schedule',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: buildImage(imageUrl),
                                    ),
                                  ),
                                );
                              }

                              // fallback: show placeholder image
                              return Image.asset(
                                'assets/images/Rectangle 23870-3.png',
                                fit: BoxFit.contain,
                                height: 220,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
