import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../data/repo/lecture_pdf_repo.dart';
import '../view_models/lec_pdf_cubit.dart';
import '../view_models/lec_pdf_state.dart';
import 'widgets/detail_item.dart';

class LecturePdfView extends StatelessWidget {
  final String lectureId;

  const LecturePdfView({super.key, required this.lectureId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LecturePdfCubit(
        LecturePdfRepo(
          dioConsumer: DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl),
        ),
      )..getLecturePdf(lectureId),
      child: const LecturePdfViewBody(),
    );
  }
}

class LecturePdfViewBody extends StatelessWidget {
  const LecturePdfViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LecturePdfCubit, LecturePdfState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          appBar: AppBarWidget(title: "PDF"),

          body: Builder(
            builder: (_) {
              if (state is LecturePdfLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is LecturePdfFailure) {
                return Center(child: Text(state.message));
              }

              if (state is LecturePdfSuccess) {
                final pdf = state.pdf;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: DetailItem(
                    icon: Icons.picture_as_pdf_outlined,
                    label: "Lecture PDF",
                    isDownloadedIcon: true,
                    isChecked: true,
                    onChanged: (val) {},
                    onTap: () {
                      launchUrl(Uri.parse(pdf.fileUrl));

                      final url = pdf.fileUrl;
                      print(url);
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
