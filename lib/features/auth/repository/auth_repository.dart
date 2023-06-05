import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:whatsapp_clone/core/constants/firebase_constants.dart';
import 'package:whatsapp_clone/core/failure.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';
import 'package:whatsapp_clone/models/user.dart' as model;
import '../../../core/type_defs.dart';

final authRepoProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthRepository(auth: auth, firestore: firestore, ref: ref);
});

final smsCodeProvider = StateProvider<String?>((ref) => null);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final Ref _ref;
  AuthRepository(
      {required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      required Ref ref})
      : _auth = auth,
        _firestore = firestore,
        _ref = ref;

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

  FutureVoid saveUser({required model.User userModel})async{
    try{

      await _users.doc(userModel.uid).set(userModel.toMap());
      return right(null);
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
