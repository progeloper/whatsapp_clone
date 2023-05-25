import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';


final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  final repo = ref.read(authRepoProvider);
  return AuthController(repo: repo);
});


class AuthController extends StateNotifier<bool>{
  final AuthRepository _repo;
  AuthController({required AuthRepository repo}) : _repo = repo, super(false);

}