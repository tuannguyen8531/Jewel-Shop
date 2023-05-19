import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewel_project/firebase/home.dart';
import 'package:jewel_project/firebase/pagelistall.dart';
import 'demo_data.dart';
import 'widget_connect_firebase.dart';

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnection(
      errorMessage: "Lỗi con mẹ nó rồi!",
      connectingMessage: "Xoay, xoay nữa, xoay mãi...",
      builder: (context) => HomePage(),
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
      body: SingleChildScrollView(
        child: Container(
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
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    gems.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CategoryCard(
                        icon: gems[index].icon,
                        type: gems[index].title,
                        press: gems[index].press,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Our product",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageList(),
                        ),
                      );
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductCard(
                    name: gemstones[0].name,
                    price: gemstones[0].price,
                    image: gemstones[0].image,
                    press: () {
                      txtSearch.text = gemstones[0].name;
                    },
                  ),
                  ProductCard(
                    name: gemstones[1].name,
                    price: gemstones[1].price,
                    image: gemstones[1].image,
                    press: () {
                      txtSearch.text = gemstones[1].name;
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductCard(
                    name: gemstones[2].name,
                    price: gemstones[2].price,
                    image: gemstones[2].image,
                    press: () {
                      txtSearch.text = gemstones[2].name;
                    },
                  ),
                  ProductCard(
                    name: gemstones[3].name,
                    price: gemstones[3].price,
                    image: gemstones[3].image,
                    press: () {
                      txtSearch.text = gemstones[3].name;
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductCard(
                    name: gemstones[4].name,
                    price: gemstones[4].price,
                    image: gemstones[4].image,
                    press: () {
                      txtSearch.text = gemstones[4].name;
                    },
                  ),
                  ProductCard(
                    name: gemstones[5].name,
                    price: gemstones[5].price,
                    image: gemstones[5].image,
                    press: () {
                      txtSearch.text = gemstones[5].name;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.press,
  }) : super(key: key);
  String name, price, image;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 1,
        shadowColor: Colors.blue,
        child: Column(
          children: [
            Image.network(
              image,
              height: 180,
            ),
            Text(name),
            Text(
              "\$$price",
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({
    Key? key,
    required this.icon,
    required this.type,
    required this.press,
  }) : super(key: key);
  String icon;
  String type;
  VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: press,
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
                style: const TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
