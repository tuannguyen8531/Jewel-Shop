import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/menu.svg"),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Jewel Shop",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Connected!"),
      ),
    );
  }
}
