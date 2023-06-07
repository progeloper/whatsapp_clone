import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/message.dart';

class Chat{
  final String chatId;
  final String avatar;
  final String name;
  final List<String> members;
  final Message lastMessage;
  final bool isGroup;

//<editor-fold desc="Data Methods">
  const Chat({
    required this.chatId,
    required this.avatar,
    required this.name,
    required this.members,
    required this.lastMessage,
    required this.isGroup,
  });

  Chat copyWith({
    String? chatId,
    String? avatar,
    String? name,
    List<String>? members,
    Message? lastMessage,
    bool? isGroup,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      isGroup: isGroup ?? this.isGroup,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': this.chatId,
      'avatar': this.avatar,
      'name': this.name,
      'members': this.members,
      'lastMessage': this.lastMessage,
      'isGroup': this.isGroup,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatId: map['chatId'] as String,
      avatar: map['avatar'] as String,
      name: map['name'] as String,
      members: List<String>.from(map['members']),
      lastMessage: map['lastMessage'] as Message,
      isGroup: map['isGroup'] as bool,
    );
  }

//</editor-fold>
}