import '../../data/models/lecture_pdf_model.dart';

abstract class LecturePdfState {}

class LecturePdfInitial extends LecturePdfState {}

class LecturePdfLoading extends LecturePdfState {}

class LecturePdfSuccess extends LecturePdfState {
  final LecturePdfModel pdf;

  LecturePdfSuccess(this.pdf);
}

class LecturePdfFailure extends LecturePdfState {
  final String message;

  LecturePdfFailure(this.message);
}