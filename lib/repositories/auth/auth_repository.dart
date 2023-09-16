import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../models/user_model.dart';
import '../user/user_repository.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;
  
  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<auth.User?> signUp({
    required String password,
    required User user,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      )
          .then((value) {
        _userRepository.createUser(
          user.copyWith(id: value.user!.uid),
        );
      });
    } catch (_) {}
  }
}