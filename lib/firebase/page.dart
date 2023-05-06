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
      builder: (context) => PageHome(),
    );
  }
}

class PageHome extends StatelessWidget {
  PageHome({Key? key}) : super(key: key);
  final TextEditingController txtSearch = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
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
              "Jewel Store",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/notification.svg"),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Explore our gemstones",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("we choose the best for you..."),
            const SizedBox(height: 25),
            Form(
              key: formState,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  TextFormField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Search everything...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () => txtSearch.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    validator: (value) {
                      return value!.isEmpty ? "Nothing to search..." : null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
