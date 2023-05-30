import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone/models/user.dart' as model;
import '../../../core/utils.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final repo = ref.read(authRepoProvider);
  return AuthController(repo: repo);
});

final userProvider = StateProvider<model.User?>((ref)=>null);

final authStateChangeProvider = StreamProvider((ref) {
  return ref.read(authControllerProvider.notifier).authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repo;
  AuthController({required AuthRepository repo})
      : _repo = repo,
        super(false);

  Stream<User?> get authStateChange => _repo.authStateChange;

  void registerUser(String mobile, BuildContext context) async {
    final res = await _repo.registerUser(mobile, context);
    res.fold(
      (l) => showSnackBar(context, l.error),
      (r) => null,
    );
  }

  Stream getUserData(String uid){
    return _repo.getUserData(uid);
  }
}
