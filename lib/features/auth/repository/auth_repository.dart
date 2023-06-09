import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/core/constants/firebase_constants.dart';
import 'package:whatsapp_clone/core/failure.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';
import 'package:whatsapp_clone/core/providers/storage_repository_provider.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/models/user.dart' as model;
import '../../../core/constants/constants.dart';
import '../../../core/type_defs.dart';
import '../../../core/utils.dart';

final authRepoProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  final storageRepo = ref.read(storageRepositoryProvider);
  return AuthRepository(auth: auth, firestore: firestore, ref: ref, storageRepo: storageRepo);
});

final smsCodeProvider = StateProvider<String?>((ref) => null);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorageRepository _storageRepo;
  final Ref _ref;
  AuthRepository(
      {required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      required Ref ref, required FirebaseStorageRepository storageRepo})
      : _auth = auth,
        _firestore = firestore,
        _ref = ref, _storageRepo = storageRepo;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureVoid registerUser(String mobile, BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          verificationCompleted: (PhoneAuthCredential credential)async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw e.message!;
          },
          codeSent: (String verificationId, int? forceResendingToken) async {
            Routemaster.of(context).push('/enter-otp-screen/$verificationId/$mobile');
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          });

      return right(null);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String OTP,
    required String number
  }) async {
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: OTP);
      await _auth.signInWithCredential(credential);
        Routemaster.of(context).push('/create-profile-screen/$number');
        return right(null);
    }on FirebaseException catch(e){
      throw e.message!;
    } catch(e){
      return left(Failure(e.toString()));
    }
  }

  FutureEither<model.User> saveUser({required BuildContext context, required String name, required String about, required Timestamp lastOnline, required Uint8List? picture})async{
    try{
      String displayPic = Constants.defaultAvatar;
      if(picture != null){
        final res = await _storageRepo.storeImage(path: '/profile-pictures', id: _auth.currentUser!.uid, file: picture!);
        res.fold((l) => showSnackBar(context, l.error), (r){displayPic = r;},);
      }
      final model.User userModel = model.User(name: name, uid: _auth.currentUser!.uid, number: _auth.currentUser!.phoneNumber!, displayPic: displayPic, about: about, statusPosts: [], isOnline: false, lastOnline: lastOnline, contacts: []);
      await _users.doc(userModel.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch(e){
      throw e.message!;
    } catch(e){
      return left(Failure(e.toString()));
    }
  }

  Stream<model.User> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => model.User.fromMap(event.data() as Map<String, dynamic>));
  }

}
