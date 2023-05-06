import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'demo_data.dart';
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
            const SizedBox(height: 25),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  gems.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CategoryCard(
                      icon: gems[index].icon,
                      type: gems[index].title,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, required this.icon, required this.type})
      : super(key: key);
  String icon;
  String type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Image.asset(
                icon,
                height: 50,
              ),
              const SizedBox(height: 5),
              Text(
                type,
                style: TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
