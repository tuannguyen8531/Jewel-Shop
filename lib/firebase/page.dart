import 'package:flutter/material.dart';
import 'widget_connect_firebase.dart';

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnection(
      errorMessage: "Lỗi con mẹ nó rồi!",
      connectingMessage: "Xoay, xoay nữa, xoay mãi...",
      builder: (context) => const PageHome(),
    );
  }
}

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: Center(
        child: Text("Connected!"),
      ),
    );
  }
}
