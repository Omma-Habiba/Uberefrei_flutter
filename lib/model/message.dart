import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final DateTime date;
  final String sender;

  const Message({
    required this.content,
    required this.date,
    required this.sender,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'date': date,
      'sender': sender,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      date: (json['date'] as Timestamp).toDate(), // Conversion Timestamp en DateTime      isSentByMe: json['isSentByMe'],
      sender: json['sender'],
    );
  }
}