class Chat{
  final String chatId;
  final List<String> members;

//<editor-fold desc="Data Methods">
  const Chat({
    required this.chatId,
    required this.members,
  });

  Chat copyWith({
    String? chatId,
    List<String>? members,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': this.chatId,
      'members': this.members,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatId: map['chatId'] as String,
      members: map['members'] as List<String>,
    );
  }

//</editor-fold>
}