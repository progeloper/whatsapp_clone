import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/core/constants/constants.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';
import 'package:whatsapp_clone/core/providers/storage_repository_provider.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone/models/user.dart' as model;
import '../../../core/utils.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final repo = ref.read(authRepoProvider);
  final storageRepo = ref.read(storageRepositoryProvider);
  final auth = ref.read(firebaseAuthProvider);
  return AuthController(repo: repo, storageRepo: storageRepo, ref: ref,);
});

final userProvider = StateProvider<model.User?>((ref)=>null);

final authStateChangeProvider = StreamProvider((ref) {
  return ref.read(authControllerProvider.notifier).authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repo;
  final FirebaseStorageRepository _storageRepo;
  final Ref _ref;//use only to get uid
  AuthController({required AuthRepository repo, required FirebaseStorageRepository storageRepo, required Ref ref,})
      : _repo = repo,
  _storageRepo = storageRepo,
  _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _repo.authStateChange;

  void registerUser(String mobile, BuildContext context) async {
    final res = await _repo.registerUser(mobile, context);
    res.fold(
      (l) => showSnackBar(context, l.error),
      (r) => null,
    );
  }

  void verifyOTP(BuildContext context, String verificationId, String OTP, String number)async{
    final res = await _repo.verifyOTP(context: context, verificationId: verificationId, OTP: OTP, number: number);
    res.fold((l) => showSnackBar(context, l.error), (r) => null);
  }

  Future<void> saveUser({required BuildContext context, required String name, required String number, Uint8List? picture, required String about}) async {

    DateTime currentTime = DateTime.now();
    Timestamp lastOnline = Timestamp.fromDate(currentTime);
    final result = await _repo.saveUser(name: name, picture: picture, about: about, lastOnline: lastOnline, context: context);
    result.fold((l) => showSnackBar(context, l.error), (r) {
      _ref.read(userProvider.notifier).update((state) => r);
    },);
  }

  Stream getUserData(String uid){
    return _repo.getUserData(uid);
  }
}
