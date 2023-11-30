import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eferei2023gr109/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import '../model/message.dart';
import '../service/conversation_service.dart';

class ChatView extends StatefulWidget {
  final String uberId;
  final String uberName;
  final bool isUber;

  const ChatView({Key? key, required this.uberId, required this.uberName, required this.isUber}) : super(key: key);
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Stream<QuerySnapshot>? _conversationStream;
  List<Message> messages = [];
  late String myId;

  @override
  void initState() {
    super.initState();
    myId = widget.isUber ? widget.uberId : "us_1";
    _conversationStream = FirebaseFirestore.instance.collection('conversations').snapshots();
    _loadConversationData();
  }

  Future<void> _loadConversationData() async {
    //print("Entrer dans loadConversation");
    Conversation? conversation = await ConversationService().getConversationById(widget.uberId);
    if (conversation != null) {
      List<Message> conversationMessages = conversation.messages;
      messages = conversationMessages.toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUber? "Ochaco" : widget.uberName),
      ),
      body:
      Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align (
                alignment: message.sender == myId
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.content),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.greenAccent,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Ecrivez votre message ici...'
              ),
              onSubmitted: (text){
                final message = Message(
                  content: text,
                  date: DateTime.now(),
                  sender: myId,
                );
                List<Map<String, dynamic>> messagesJson = messages.map((message) => message.toJson()).toList();
                Map<String, dynamic> conversationMap = {
                  'titre': "uber"+ widget.uberId.replaceFirst("ub_", ""),
                  'messages': messagesJson,
                };
                setState(() {
                  messages.add(message);
                  ConversationService().addMessageToConversation(widget.uberId, message);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}