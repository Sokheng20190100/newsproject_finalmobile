import 'package:cloud_firestore/cloud_firestore.dart';

List<ListInfo> getListInfoListFromSnapshot(List<QueryDocumentSnapshot> data){
  return data.map((e) => ListInfo.fromSnapshot(e)).toList();
}

class ListInfo {
  static const String collectionName = "listinfo";
  static const String titleString = "title";
  static const String dateString = "date";
  static const String captionString = "caption";
  static const String imageString = "image";
  static const String decsString = "decs";


  String title;
  String date;
  String caption;
  String image;
  String decs;

  DocumentReference reference;

  ListInfo({this.title, this.date ,this.caption ,this.image , this.decs ,this.reference});

  ListInfo.fromMap(Map map, {this.reference}) {
    title = map[titleString];
    date = map[dateString];
    caption = map[captionString];
    image = map[imageString];
    decs = map[decsString];
  }

  ListInfo.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Map<String, dynamic> get toMap => {
    dateString: date,
    titleString: title,
    captionString: caption,
    imageString: image,
    decsString: decs,
  };
}