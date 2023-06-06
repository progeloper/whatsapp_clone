import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/constants/firebase_constants.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';

import '../../../models/chat.dart';

final homeRepoProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return HomeRepository(firestore: firestore);
});

class HomeRepository {
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _chats => _firestore.collection(FirebaseConstants.chatsCollections);

  Stream<List<Chat>> getUserChats(String uid){
    return _chats.where('members', arrayContains: uid).orderBy('lastMessage',descending: true).snapshots().map((event) => event.docs.map((e) => Chat.fromMap(e.data() as Map<String, dynamic>)).toList()) ;
  }
}
