import 'package:cloud_firestore/cloud_firestore.dart';

class Jewel {
  String id, name, color, description, idType, image;
  String origin, size, weight;
  int price;

  Jewel({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
    required this.idType,
    required this.image,
    required this.origin,
    required this.size,
    required this.weight,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'description': description,
      'idType': idType,
      'image': image,
      'origin': origin,
      'size': size,
      'weight': weight,
      'price': price,
    };
  }

  factory Jewel.fromJson(Map<String, dynamic> map) {
    return Jewel(
      id: map['id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      description: map['description'] as String,
      idType: map['idType'] as String,
      image: map['image'] as String,
      origin: map['origin'] as String,
      size: map['size'] as String,
      weight: map['weight'] as String,
      price: map['price'] as int,
    );
  }
}

class JewelSnapshot {
  Jewel jewel;
  DocumentReference documentReference;

  JewelSnapshot({
    required this.jewel,
    required this.documentReference,
  });

  Map<String, dynamic> toSnapshot() {
    return {
      'jewel': jewel,
      'documentReference': documentReference,
    };
  }

  factory JewelSnapshot.fromSnapshot(DocumentSnapshot docSnapJW) {
    return JewelSnapshot(
      jewel: Jewel.fromJson(docSnapJW.data() as Map<String, dynamic>),
      documentReference: docSnapJW.reference,
    );
  }

  static Future<List<JewelSnapshot>> getListJewels() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("gemstones").get();
    return qs.docs.map((doc) => JewelSnapshot.fromSnapshot(doc)).toList();
  }

}