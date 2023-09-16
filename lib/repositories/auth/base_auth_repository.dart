import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../models/user_model.dart';
abstract class BaseAuthRepository {
  Stream<auth.User?> get user;

  Future<auth.User?> signUp({
    required String password,
    required User user,
  });
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}