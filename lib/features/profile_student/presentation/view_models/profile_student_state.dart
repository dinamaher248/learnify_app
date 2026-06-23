import '../../data/models/student_profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final StudentProfileModel profile;

  ProfileSuccess(this.profile);
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileUpdateFailure extends ProfileState {
  final String error;

  ProfileUpdateFailure(this.error);
}