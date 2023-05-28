import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/data/jewel_data.dart';
import 'package:jewel_project/page/pagedetail.dart';

class PageTypes extends StatelessWidget {
  const PageTypes({super.key,
    required this.type,
  });
  final String type;
  @override
  Widget build(BuildContext context) {
    String name;
    switch(type) {
      case "ER" : name = "Emerald"; break;
      case "DA" : name = "Diamond"; break;
      case "RB" : name = "Ruby"; break;
      case "SP" : name = "Sapphire"; break;
      default : name = "Gemstone"; break;
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
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
                // Lấy danh sách các JewelSnapshot
                var list = snapshot.data!;
                List<JewelSnapshot> gems = [];
                // Kiểm tra xem Jewel trong JewelSnapshot thuộc loại nào
                for(var gem in list) {
                  // Nếu cùng loại thì add vào
                  if(gem.jewel.idType==type ||
                      gem.jewel.name.toLowerCase().contains(type) ||
                      gem.jewel.name.contains(type)
                  ) gems.add(gem);
                }
                if(gems.isEmpty) {
                  return const Center(
                    child: Text("No product found."),
                  );
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
