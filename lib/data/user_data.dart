import 'package:cloud_firestore/cloud_firestore.dart';

class UserItem {
  String id, name, address, email, phone;
  bool isUpdated;
  int age;

  UserItem({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.isUpdated,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'isUpdated': isUpdated,
      'age': age,
    };
  }

  factory UserItem.fromJson(Map<String, dynamic> map) {
    return UserItem(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      isUpdated: map['isUpdated'] as bool,
      age: map['age'] as int,
    );
  }
}

class UserSnapshot {
  UserItem user;
  DocumentReference documentReference;

  UserSnapshot({
    required this.user,
    required this.documentReference,
  });

  Map<String, dynamic> toSnapshot() {
    return {
      'user': user,
      'documentReference': documentReference,
    };
  }

  factory UserSnapshot.fromSnapshot(DocumentSnapshot docSnapUser) {
    return UserSnapshot(
      user: UserItem.fromJson(docSnapUser.data() as Map<String, dynamic>),
      documentReference: docSnapUser.reference,
    );
  }

  // Hàm lấy danh sách người dùng trên firebase về, truy cập toàn cục
  static Stream<List<UserSnapshot>> getAllUser() {
    // Tạo một Stream lấy các document trong collection "users"
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("users").snapshots();
    // Chuyển Stream từ Stream<QuerySnapshot> thành
    return streamQS.map((qs) => qs.docs)
        .map((listDocSnap) => listDocSnap.map((docSnap) =>
        UserSnapshot.fromSnapshot(docSnap)).toList());
  }

  static Future<DocumentReference> add(UserItem user) async {
    return FirebaseFirestore.instance.collection("users").add(user.toJson());
  }

  Future<void> delete() async {
    return documentReference.delete();
  }

  Future<void> update(UserItem user) async {
    return documentReference.update(user.toJson());
  }
}