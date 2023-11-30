import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/conversation.dart';
import '../model/message.dart';

class ConversationService {
   final CollectionReference? _conversation = FirebaseFirestore.instance.collection('conversations');

   void addConversation(Map<String, dynamic> conversationMap) async {
     try {
       debugPrint("CONVERSATION = $conversationMap");
       await _conversation?.doc("user1_uber1").set(conversationMap);
       print("Data added successfully");
     } catch (e) {
       print("Error adding data: $e");
     }
   }

   Future<void> addMessageToConversation(String uberId, Message message) async {
     try {
       final conversationId = "user1_uber${uberId.replaceFirst("ub_", "")}";
       final conversationRef = _conversation?.doc(conversationId);
       final conversationSnapshot = await conversationRef?.get();

       if (conversationSnapshot != null && conversationSnapshot.exists) {
         // La conversation existe, ajoutez le message à la liste des messages
         await conversationRef?.update({
           'messages': FieldValue.arrayUnion([message.toJson()]),
           'titre': uberId
         });
         print("Message added to existing conversation");
       } else {
         // La conversation n'existe pas, créez une nouvelle conversation
         final newConversation = {
           'messages': [message.toJson()],
           'titre': uberId
         };

         await _conversation?.doc(conversationId).set(newConversation);
         print("New conversation created with message");
       }
     } catch (e) {
       print("Error adding data: $e");
       throw e; // Propagez l'erreur pour la gérer dans la partie appelante si nécessaire
     }
   }

   Future<Conversation?> getConversationById(String uberId) async {
     try {
       final conversationId = 'user1_uber'+uberId.replaceFirst("ub_", "");
       DocumentSnapshot<Object?>? conversationSnapshot =
       await _conversation?.doc(conversationId).get();
       if (conversationSnapshot!.exists) {
         // Récupérer les données de la conversation
         Map<String, dynamic> data = conversationSnapshot.data() as Map<String, dynamic>;

         // Créer une instance de la classe Conversation à partir des données récupérées
         Conversation conversation = Conversation.fromJson(data);
         return conversation;

       } else {
         print('La conversation avec l\'ID $conversationId n\'existe pas.');
         return null;
       }
     } catch (e) {
       print('Erreur lors de la récupération de la conversation : $e');
       return null;
     }
   }

}
