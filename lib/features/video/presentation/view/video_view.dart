import 'dart:io' show Platform;

import 'package:chewie/chewie.dart';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:learnify_app/core/utils/app_styles.dart';

import 'package:learnify_app/core/utils/assets.dart';

import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';

import 'package:sizer/sizer.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:video_player/video_player.dart';

import '../../../../core/Api/dio_consumer.dart';

import '../../../../core/Api/endpoints.dart';

import '../../data/repo/lecture_video_repo.dart';

import '../view_models/video_cubit.dart';

import '../view_models/video_state.dart';

class VideoView extends StatefulWidget {
  final String? lectureId;

  final String? lectureTitle;

  const VideoView({super.key, this.lectureId, this.lectureTitle});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _videoController;

  ChewieController? _chewieController;

  bool _initialized = false;

  Future<void> _initAndPlay(
    String url,

    String lectureId,

    VideoCubit cubit,
  ) async {
    if (_initialized) return;

    final messenger = ScaffoldMessenger.of(context);

    // If running on desktop (Windows/macOS/Linux) and the video_player

    // plugin platform implementation isn't available, avoid calling

    // VideoPlayerController and open externally as a fallback.

    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      cubit.markVideoViewed(lectureId);

      return;
    }

    try {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));

      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,

        autoInitialize: true,

        autoPlay: true,

        looping: false,

        allowPlaybackSpeedChanging: true,

        // تأكدي من إعدادات الـ aspect ratio هنا لضمان العرض السليم
        aspectRatio: _videoController!.value.aspectRatio,
      );
    } on UnimplementedError catch (_) {
      // video_player platform implementation missing -> fallback to external player

      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      cubit.markVideoViewed(lectureId);

      return;
    } catch (e) {
      // show a helpful message and keep the app alive

      if (mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Error loading video: $e')),
        );
      }

      return;
    }

    _videoController!.addListener(() {
      final vc = _videoController!;

      if (vc.value.isInitialized &&
          vc.value.position >= vc.value.duration &&
          !vc.value.isPlaying) {
        cubit.markVideoViewed(lectureId);
      }
    });

    _initialized = true;

    if (mounted) setState(() {});
  }

  void _disposeControllers() {
    _chewieController?.dispose();

    _videoController?.dispose();

    _chewieController = null;

    _videoController = null;

    _initialized = false;
  }

  @override
  void dispose() {
    _disposeControllers();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lectureId = widget.lectureId;

    final lectureTitle = widget.lectureTitle;

    return BlocProvider(
      create: (_) => VideoCubit(
        LectureVideoRepo(
          dioConsumer: DioConsumer(
            dio: Dio(),

            baseUrl: Endpoints.baseAcadimicUrl,
          ),
        ),
      ),

      child: BlocListener<VideoCubit, VideoState>(
        listener: (context, state) async {
          final messenger = ScaffoldMessenger.of(context);

          if (state is VideoLoading) {
            messenger.showSnackBar(
              const SnackBar(content: Text('Loading video...')),
            );
          }

          if (state is VideoSuccess) {
            if (lectureId != null) {
              final cubit = context.read<VideoCubit>();

              await _initAndPlay(state.video.videoUrl, lectureId, cubit);
            }
          }

          if (state is VideoFailure) {
            messenger.showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Video'),

              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (lectureId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No lecture id')),
                          );

                          return;
                        }

                        if (!_initialized) {
                          context.read<VideoCubit>().getLectureVideo(lectureId);
                        } else {
                          if (_videoController!.value.isPlaying) {
                            await _videoController!.pause();
                          } else {
                            await _videoController!.play();
                          }

                          if (mounted) setState(() {});
                        }
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),

                        child: SizedBox(
                          height: 250,

                          width: double.infinity,

                          child:
                              _initialized &&
                                  _videoController != null &&
                                  _videoController!.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoController!.value.aspectRatio == 0
                                      ? 16 / 9
                                      : _videoController!.value.aspectRatio,

                                  child: Chewie(controller: _chewieController!),
                                )
                              : Stack(
                                  alignment: Alignment.center,

                                  children: [
                                    Image.asset(
                                      AppAssets.lecture_video_view,

                                      height: 250,

                                      width: double.infinity,

                                      fit: BoxFit.cover,
                                    ),

                                    Image.asset(
                                      AppAssets.video_icon,

                                      height: 30.h,

                                      width: 30.w,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          lectureTitle ?? lectureId ?? 'Lecture',

                          style: AppStyles.style16MediumUppercase.copyWith(
                            color: const Color(0xFF24234D),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,

                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFC6D1FB),

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            '5 Min Video',

                            style: AppStyles.style14MediumInter.copyWith(
                              color: const Color(0xFF5047E4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

