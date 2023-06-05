import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/failure.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';
import 'package:whatsapp_clone/core/type_defs.dart';


final storageRepositoryProvider = Provider((ref) {
  final FirebaseStorage storage = ref.read(firebaseStorageProvider);
  return FirebaseStorageRepository(storage: storage);
});

class FirebaseStorageRepository{
  final FirebaseStorage _storage;
  FirebaseStorageRepository({required FirebaseStorage storage}):_storage = storage;
  FutureEither<String> storeImage({required String path, required String id, required Uint8List file})async{
    try{
      final Reference ref = _storage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snap = await uploadTask;
      return right(await snap.ref.getDownloadURL());
    }on FirebaseException catch(e){
      throw e.message!;
    } catch(e){
      return left(Failure(e.toString()));
    }
  }
}