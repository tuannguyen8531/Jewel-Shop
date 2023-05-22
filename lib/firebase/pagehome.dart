import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/firebase/jewel_data.dart';
import 'package:jewel_project/firebase/app.dart';
import 'package:jewel_project/firebase/pagedetail.dart';
import 'package:jewel_project/firebase/pagelist.dart';
import 'package:jewel_project/firebase/pagelistall.dart';
import 'package:jewel_project/firebase/sidemenu.dart';
import 'package:jewel_project/firebase/type_data.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController txtSearch = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset("assets/icons/menu.svg"),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
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
                            name: gemstones[0].jewel.name,
                            price: gemstones[0].jewel.price.toString(),
                            image: gemstones[0].jewel.image,
                            press: () {
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[0]),),
                              );
                            },
                          ),
                          ProductCard(
                            name: gemstones[1].jewel.name,
                            price: gemstones[1].jewel.price.toString(),
                            image: gemstones[1].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[1]),),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProductCard(
                            name: gemstones[2].jewel.name,
                            price: gemstones[2].jewel.price.toString(),
                            image: gemstones[2].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[2]),),
                              );
                            },
                          ),
                          ProductCard(
                            name: gemstones[3].jewel.name,
                            price: gemstones[3].jewel.price.toString(),
                            image: gemstones[3].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[3]),),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProductCard(
                            name: gemstones[4].jewel.name,
                            price: gemstones[4].jewel.price.toString(),
                            image: gemstones[4].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[4]),),
                              );
                            },
                          ),
                          ProductCard(
                            name: gemstones[5].jewel.name,
                            price: gemstones[5].jewel.price.toString(),
                            image: gemstones[5].jewel.image,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gemstones[5]),),
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
