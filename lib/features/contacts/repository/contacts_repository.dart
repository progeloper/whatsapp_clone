import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/constants/firebase_constants.dart';
import 'package:whatsapp_clone/core/failure.dart';

import '../../../core/type_defs.dart';

class ContactsRepository {
  final FirebaseFirestore _firestore;
  const ContactsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  FutureEither<List<Contact>> getContacts() async{
    List<Contact> contacts = [];
    try{
      if(await FlutterContacts.requestPermission()){
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    }catch(e){
      return left(Failure(e.toString()));
    }
    return right(contacts);
  }
}
