import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/contacts/repository/contacts_repository.dart';

final getContactsProvider = FutureProvider((ref) async {
  final repo = ref.read(contactRepoProvider);
  return repo.getContacts();
});

final contactsControllerProvider = Provider((ref) {
  final repo = ref.read(contactRepoProvider);
  return ContactsController(repo: repo, ref: ref);
});

class ContactsController{
  final ContactsRepository _repo;
  final Ref _ref;
  ContactsController({required ContactsRepository repo, required Ref ref}) : _repo = repo, _ref = ref;

  void selectContact(BuildContext context, Contact selectedContact){
    _repo.selectContact(context, selectedContact);
  }

}