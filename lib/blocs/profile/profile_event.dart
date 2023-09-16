import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../models/models.dart';
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final auth.User? authUser;

  const LoadProfile(this.authUser);

  @override
  List<Object?> get props => [authUser];
}

class UpdateProfile extends ProfileEvent {
  final User user;

  const UpdateProfile({required this.user});

  @override
  List<Object?> get props => [user];
}