import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/core/common/error_text.dart';
import 'package:whatsapp_clone/core/common/loading_screen.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/home/controller/home_controller.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {



  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return ref.watch(getUserChatsProvider(user!.uid)).when(
          data: (chats) {
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
              },
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const LoadingScreen(),
        );
  }
}
