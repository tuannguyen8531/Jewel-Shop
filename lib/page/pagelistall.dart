import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/page/pagedetail.dart';
import 'package:jewel_project/data/jewel_data.dart';

class PageList extends StatelessWidget {
  const PageList({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Text(
              "Products",
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
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.extent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  children: gemstones
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
