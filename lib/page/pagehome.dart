import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jewel_project/data/jewel_data.dart';
import 'package:jewel_project/page/component.dart';
import 'package:jewel_project/page/pagedetail.dart';
import 'package:jewel_project/page/pagelist.dart';
import 'package:jewel_project/page/pagelistall.dart';
import 'package:jewel_project/data/type_data.dart';

class PageHome extends StatelessWidget {
  PageHome({Key? key}) : super(key: key);
  final TextEditingController txtSearch = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<JewelSnapshot>>(
        future: JewelSnapshot.getListJewels(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(
              child: Text("Error!"),
            );
          }
          else {
            if(!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              var gemstones = snapshot.data!;
              var listRandom = randomShowProduct(gemstones);
              return SingleChildScrollView(
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
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  // Nhấn nút tìm kiếm đưa text tìm kiếm vào PageType.
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PageTypes(type: txtSearch.text),
                                      ),
                                    )
                                  },
                                ),
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
                      // Một widget FutureBuilder có dữ liệu là một List<JewelTypeSnapshot>
                      FutureBuilder<List<JewelTypeSnapshot>>(
                        future: JewelTypeSnapshot.getListJewelType(),
                        builder: (context, snap) {
                          if(snap.hasError) {
                            return const Center(
                              child: Text("Error!"),
                            );
                          }
                          else {
                            if(!snap.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            else {
                              var listTypes = snap.data!;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    listTypes.length,
                                        (index) => Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: CategoryCard(
                                        icon: listTypes[index].jewelType.iconType,
                                        type: listTypes[index].jewelType.nameType,
                                        press: () {
                                          // Chuyển đến PageType với tên loại
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PageTypes(type: listTypes[index].jewelType.idType),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.local_fire_department_rounded, color: Colors.red,),
                              Text(
                                "Hot products",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PageList(icon: BackIcon(),),
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
                            name: gemstones[listRandom[0]].jewel.name,
                            price: gemstones[listRandom[0]].jewel.price.toString(),
                            image: gemstones[listRandom[0]].jewel.image,
                            press: () {
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[listRandom[0]]),),
                              );
                            },
                          ),
                          ProductCard(
                            name: gemstones[listRandom[1]].jewel.name,
                            price: gemstones[listRandom[1]].jewel.price.toString(),
                            image: gemstones[listRandom[1]].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[listRandom[1]]),),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProductCard(
                            name: gemstones[listRandom[2]].jewel.name,
                            price: gemstones[listRandom[2]].jewel.price.toString(),
                            image: gemstones[listRandom[2]].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[listRandom[2]]),),
                              );
                            },
                          ),
                          ProductCard(
                            name: gemstones[listRandom[3]].jewel.name,
                            price: gemstones[listRandom[3]].jewel.price.toString(),
                            image: gemstones[listRandom[3]].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[listRandom[3]]),),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProductCard(
                            name: gemstones[listRandom[4]].jewel.name,
                            price: gemstones[listRandom[4]].jewel.price.toString(),
                            image: gemstones[listRandom[4]].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[listRandom[4]]),),
                              );
                            },
                          ),
                          ProductCard(
                            name: gemstones[listRandom[5]].jewel.name,
                            price: gemstones[listRandom[5]].jewel.price.toString(),
                            image: gemstones[listRandom[5]].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[listRandom[5]]),),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }


}

List<int> randomShowProduct(List<JewelSnapshot> list) {
  int max = list.length;
  List<int> randomNumbers = [];
  while(randomNumbers.length < 6) {
    var random = Random().nextInt(max);
    while(randomNumbers.contains(random)) {
      random = Random().nextInt(max);
    }
    randomNumbers.add(random);
  }
  return randomNumbers;
}


