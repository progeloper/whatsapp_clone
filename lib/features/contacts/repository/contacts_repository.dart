import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/constants/firebase_constants.dart';
import 'package:whatsapp_clone/core/failure.dart';
import 'package:whatsapp_clone/core/providers/firebase_providers.dart';
import 'package:whatsapp_clone/core/utils.dart';
import 'package:whatsapp_clone/models/user.dart';

import '../../../core/type_defs.dart';

final contactRepoProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return ContactsRepository(firestore: firestore);
});

class ContactsRepository {
  final FirebaseFirestore _firestore;
  const ContactsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  Future<List<Contact>> getContacts() async{
    List<Contact> contacts = [];
    try{
      if(await FlutterContacts.requestPermission()){
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return contacts;
  }

  void selectContact(BuildContext context, Contact selectedContact) async{
    try{
      var users = await _users.get();
      bool isFound = false;
      String selectedNum = selectedContact.phones[0].number.replaceAll(' ', '');
      for(var doc in users.docs){
        var userModel = User.fromMap(doc.data() as Map<String, dynamic>);
        if(selectedNum == userModel.number){
          isFound = true;
          //TODO add navigation
        }
      }
      if(!isFound){
        showSnackBar(context, 'Invite ${selectedContact.name} to WhatsApp');
      }
    } catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

}
