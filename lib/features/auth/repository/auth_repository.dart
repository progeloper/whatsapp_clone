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
      UserCredential? _cred;
      _auth.verifyPhoneNumber(
          verificationCompleted: (AuthCredential credential) {},
          verificationFailed: (e) {
            throw e.message!;
          },
          codeSent: (String verificationId, int? forceResendingToken) async {
            Routemaster.of(context).push('/enter-otp-screen/$mobile');
            String? smsCode = _ref.watch(smsCodeProvider);
            AuthCredential? _credential;
            _ref.listen(smsCodeProvider, (previous, next) {
              if (next != null) {
                _credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: next);
              }
            });
            if (_credential != null) {
              _cred = await _auth.signInWithCredential(_credential!);
            }
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

  Stream<model.User> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => model.User.fromMap(event.data() as Map<String, dynamic>));
  }
}
