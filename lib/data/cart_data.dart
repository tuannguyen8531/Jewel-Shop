import 'package:cloud_firestore/cloud_firestore.dart';

class ProductItem {
  String id, name, size, image;
  int price;
  int amount;

  ProductItem({
    required this.id,
    required this.name,
    required this.size,
    required this.image,
    required this.price,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'image': image,
      'price': price,
      'amount': amount,
    };
  }

  factory ProductItem.fromJson(Map<String, dynamic> map) {
    return ProductItem(
      id: map['id'] as String,
      name: map['name'] as String,
      size: map['size'] as String,
      image: map['image'] as String,
      price: map['price'] as int,
      amount: map['amount'] as int,
    );
  }
}

class ProductItemSnapshot {
  ProductItem productItem;
  DocumentReference documentReference;

  ProductItemSnapshot({
    required this.productItem,
    required this.documentReference,
  });

  Map<String, dynamic> toSnapshot() {
    return {
      'productItem': productItem,
      'documentReference': documentReference,
    };
  }

  factory ProductItemSnapshot.fromSnapshot(DocumentSnapshot docSnapCart) {
    return ProductItemSnapshot(
      productItem: ProductItem.fromJson(docSnapCart.data() as Map<String, dynamic>),
      documentReference: docSnapCart.reference,
    );
  }

  static Stream<List<ProductItemSnapshot>> getAllProductItem() {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("cart").snapshots();
    return streamQS.map((qs) => qs.docs)
        .map((listDocSnap) => listDocSnap.map((docSnap) =>
        ProductItemSnapshot.fromSnapshot(docSnap)).toList());
  }

  static Future<DocumentReference> add(ProductItem productItem) async {
    return FirebaseFirestore.instance.collection("cart").add(productItem.toJson());
  }

  Future<void> delete() async {
    return documentReference.delete();
  }

  Future<void> update(ProductItem productItem) async {
    return documentReference.update(productItem.toJson());
  }

}