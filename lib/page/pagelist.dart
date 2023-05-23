import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/data/jewel_data.dart';
import 'package:jewel_project/page/pagedetail.dart';
import 'package:jewel_project/page/sidemenu.dart';

class PageTypes extends StatelessWidget {
  PageTypes({super.key,
    required this.type,
  });
  String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
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
                var list = snapshot.data!;
                List<JewelSnapshot> gems = [];
                for(var gem in list) {
                  if(gem.jewel.idType==type) gems.add(gem);
                }
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.extent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    children: gems
                        .map((gem) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageDetail(jewelSnapshot: gem),),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        shadowColor: Colors.blue,
                        child: Column(
                          children: [
                            Image.network(gem.jewel.image),
                            Text(gem.jewel.name),
                            Text(
                              "\$${gem.jewel.price.toString()}",
                              style: const TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                );
              }
            }
          },
        ),
    );
  }
}
