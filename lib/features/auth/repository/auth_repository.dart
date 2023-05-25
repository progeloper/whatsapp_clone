import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/core/constants/firebase_constants.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';

final authRepoProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthRepository(auth: auth, firestore: firestore);
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthRepository(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);


}
