import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String title, description, imageUrl, id, authorId;

  Blog({
    required this.title,
    required this.description,
    required this.id,
    required this.authorId,
    this.imageUrl = "",
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "id": id,
        "authorId": authorId,
        "imageUrl": imageUrl,
      };

  static Blog fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Blog(
      title: snapshot["title"],
      description: snapshot["description"],
      id: snapshot["id"],
      authorId: snapshot["authorId"],
      imageUrl: snapshot["imageUrl"] ?? "",
    );
  }

  static Blog fromMap(Map<String, dynamic> map) {
    return Blog(
      title: map["title"],
      description: map["description"],
      id: map["id"],
      authorId: map["authorId"],
      imageUrl: map["imageUrl"] ?? "",
    );
  }
}
