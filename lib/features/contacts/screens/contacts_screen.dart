import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/core/common/error_text.dart';
import 'package:whatsapp_clone/core/common/loading_screen.dart';
import 'package:whatsapp_clone/features/contacts/controller/contacts_controller.dart';
import 'package:whatsapp_clone/theme/palette.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.tabColor,
        title: Text(
          'Select Contact',
          style: TextStyle(
            color: Palette.backgroundColor,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ref.watch(getContactsProvider).when(
          data: (contacts) {
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  textColor: Palette.textColor,
                  leading: contact.photo == null
                      ? null
                      : CircleAvatar(
                          backgroundImage: MemoryImage(contact.photo!),
                          radius: 30,
                        ),
                  title: Text(
                    contact.displayName,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => LoadingScreen()),
    );
  }
}
