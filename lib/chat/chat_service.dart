import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meowtalk/model/message.dart';

class ChatService{
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String,dynamic>>> getUserStream(){
    return fireStore.collection("Users").snapshots().map((snapshot){
     return snapshot.docs.map((doc){
       final user =doc.data();
       return user;
     }).toList();
    });
  }

  Future<void> sendMessage(String receiverID,message)async{
    final String curruntUserID = auth.currentUser!.uid;
    final String curruntUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp =Timestamp.now();

    Message newMessge = Message(
        senderID: curruntUserID,
        senderEmail: curruntUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    List<String> ids =[curruntUserID,receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await fireStore.collection("chat_room").doc(chatRoomID).collection("messages").add(newMessge.toMap());



  }
  Stream<QuerySnapshot> getMessage(String userID,otherUserID){
    List<String>ids = [userID,otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return fireStore.collection("chat_room").doc(chatRoomID).collection("messages").orderBy("timestamp",descending: false).snapshots();

  }

}