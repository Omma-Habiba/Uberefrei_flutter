import 'package:eferei2023gr109/model/message.dart';

class Conversation{
  final String titre;
  final List<Message> messages;

  const Conversation({
    required this.titre,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'messages': messages,
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    List<dynamic> messagesJson = json['messages'] ?? [];
    List<Message> messages = messagesJson.map((message) => Message.fromJson(message)).toList();

    return Conversation(
      titre: json['titre'],
      messages: messages,
    );
  }
}