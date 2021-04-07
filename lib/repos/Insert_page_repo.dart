import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsproject_finalmobile/model/listinfo_news_model.dart';

Stream<QuerySnapshot> streamAllListInfo() {
  return FirebaseFirestore.instance
      .collection(ListInfo.collectionName)
      .orderBy(ListInfo.dateString, descending: true)
      .snapshots();
}

Future insertListInfo(ListInfo item) {
  return FirebaseFirestore.instance.runTransaction((transaction) async {
    CollectionReference ref = FirebaseFirestore.instance.collection(ListInfo.collectionName);
    await ref.add(item.toMap);
  }).then((value) => print("message inserted."));
}

Future updateListInfo(ListInfo item) {
  return FirebaseFirestore.instance.runTransaction((transaction) async {
    transaction.update(item.reference, item.toMap);
  }).then((value) => print("message updated."));
}

Future deleteListInfo(ListInfo item) {
  return FirebaseFirestore.instance.runTransaction((transaction) async {
    transaction.delete(item.reference);
  }).then((value) => print("message deleted."));
}
