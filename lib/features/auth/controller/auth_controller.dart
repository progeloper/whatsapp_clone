import 'dart:js_interop';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/core/constants/constants.dart';
import 'package:whatsapp_clone/core/providers/storage_repository_provider.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone/models/user.dart' as model;
import '../../../core/utils.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final repo = ref.read(authRepoProvider);
  final storageRepo = ref.read(storageRepositoryProvider);
  return AuthController(repo: repo, storageRepo: storageRepo);
});

final userProvider = StateProvider<model.User?>((ref)=>null);

final authStateChangeProvider = StreamProvider((ref) {
  return ref.read(authControllerProvider.notifier).authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repo;
  final FirebaseStorageRepository _storageRepo;
  AuthController({required AuthRepository repo, required FirebaseStorageRepository storageRepo})
      : _repo = repo,
  _storageRepo = storageRepo,
        super(false);

  Stream<User?> get authStateChange => _repo.authStateChange;

  void registerUser(String mobile, BuildContext context) async {
    final res = await _repo.registerUser(mobile, context);
    res.fold(
      (l) => showSnackBar(context, l.error),
      (r) => null,
    );
  }

  void verifyOTP(BuildContext context, String verificationId, String OTP)async{
    final res = await _repo.verifyOTP(context: context, verificationId: verificationId, OTP: OTP);
    res.fold((l) => showSnackBar(context, l.error), (r) => null);
  }

  Future<void> saveUser({required BuildContext context, required String name, required String number, Uint8List? picture, required String about}) async {
    final String uid = const Uuid().v1();
    String displayPic = Constants.defaultAvatar;
    if(!picture.isNull){
      final res = await _storageRepo.storeImage(path: '/profile-pictures', id: uid, file: picture!);
      res.fold((l) => showSnackBar(context, l.error), (r){displayPic = r;},);
    }
    DateTime currentTime = DateTime.now();
    Timestamp lastOnline = Timestamp.fromDate(currentTime);
    final model.User userModel = model.User(name: name, uid: uid, number: number, displayPic: displayPic, about: about, statusPosts: [], isOnline: false, lastOnline: lastOnline);
    _repo.saveUser(userModel: userModel);
  }

  Stream getUserData(String uid){
    return _repo.getUserData(uid);
  }
}
