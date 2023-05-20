import 'package:cloud_firestore/cloud_firestore.dart';

class JewelType {
  String idType, nameType;

  JewelType({
    required this.idType,
    required this.nameType,
  });

  Map<String, dynamic> toJson() {
    return {
      'idType': idType,
      'nameType': nameType,
    };
  }

  factory JewelType.fromJson(Map<String, dynamic> map) {
    return JewelType(
      idType: map['idType'] as String,
      nameType: map['nameType'] as String,
    );
  }
}

class JewelTypeSnapshot {
  JewelType jewelType;
  DocumentReference documentReference;

  JewelTypeSnapshot({
    required this.jewelType,
    required this.documentReference,
  });

  Map<String, dynamic> toSnapshot() {
    return {
      'jewelType': jewelType,
      'reference': documentReference,
    };
  }

  factory JewelTypeSnapshot.fromSnapshot(DocumentSnapshot docSnapJT) {
    return JewelTypeSnapshot(
      jewelType: JewelType.fromJson(docSnapJT.data() as Map<String, dynamic>),
      documentReference: docSnapJT.reference,
    );
  }
  
  static Future<List<JewelTypeSnapshot>> getListJewelType() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("jewelTypes").get();
    return qs.docs.map((doc) => JewelTypeSnapshot.fromSnapshot(doc)).toList();
  }
}