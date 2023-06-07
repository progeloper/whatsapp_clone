import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String messageId;
  final String message;
  final Timestamp time;
  final String senderId;

//<editor-fold desc="Data Methods">
  const Message({
    required this.messageId,
    required this.message,
    required this.time,
    required this.senderId,
  });

  Message copyWith({
    String? messageId,
    String? message,
    Timestamp? time,
    String? senderId,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      time: time ?? this.time,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': this.messageId,
      'message': this.message,
      'time': this.time,
      'senderId': this.senderId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      message: map['message'] as String,
      time: map['time'] as Timestamp,
      senderId: map['senderId'] as String,
    );
  }

//</editor-fold>
}