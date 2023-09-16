import 'package:e_commerce/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final auth.User? authUser;
  final User? user;

  const AuthUserChanged({
    required this.authUser,
    this.user,
  });

  @override
  List<Object?> get props => [
    authUser,
    user,
  ];
}

