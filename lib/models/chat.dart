import 'package:cloud_firestore/cloud_firestore.dart';

class Chat{
  final String chatId;
  final String avatar;
  final List<String> members;
  final Timestamp lastMessage;

//<editor-fold desc="Data Methods">
  const Chat({
    required this.chatId,
    required this.avatar,
    required this.members,
    required this.lastMessage,
  });


  Chat copyWith({
    String? chatId,
    String? avatar,
    List<String>? members,
    Timestamp? lastMessage,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      avatar: avatar ?? this.avatar,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': this.chatId,
      'avatar': this.avatar,
      'members': this.members,
      'lastMessage': this.lastMessage,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatId: map['chatId'] as String,
      avatar: map['avatar'] as String,
      members: map['members'] as List<String>,
      lastMessage: map['lastMessage'] as Timestamp,
    );
  }

//</editor-fold>
}