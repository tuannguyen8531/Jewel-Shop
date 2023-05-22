import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/firebase/pagecart.dart';
import 'package:jewel_project/firebase/pagehome.dart';
import 'package:jewel_project/firebase/pagelistall.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          InfoCard(name: "Zen", role: "Admin"),
          const SizedBox(height: 15,),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          MenuTitle(title: "Home", icon: Icons.home_filled, destination: HomePage(),),
          MenuTitle(title: "Products", icon: Icons.diamond, destination: const PageList(),),
          MenuTitle(title: "Cart", icon: Icons.shopping_cart, destination: const PageCart(),),
          MenuTitle(title: "Search", icon: Icons.search,),
          MenuTitle(title: "About Us", icon: Icons.message_outlined,),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          MenuTitle(title: "User Info", icon: Icons.account_box,),
          MenuTitle(title: "Log Out", icon: Icons.logout,),
        ],
      ),
    );
  }
}

class MenuTitle extends StatelessWidget {
  MenuTitle({super.key,
    required this.icon,
    required this.title,
    this.destination,
  });
  String title;
  IconData icon;
  Widget? destination;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if(destination!=null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destination!,),
              );
            }
            else {
              return;
            }
          },
          leading: SizedBox(
            height: 34,
            width: 34,
            child: Icon(icon, color: Colors.orange,),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({super.key,
    required this.name,
    required this.role,
  });
  String name, role;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,25,8,10),
      child: ListTile(
        leading: const CircleAvatar(
          maxRadius: 40,
          backgroundColor: Colors.grey,
          child: Icon(
            CupertinoIcons.person,
            color: Colors.orangeAccent,
            size: 30,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.orange),
        ),
        subtitle: Text(
          role,
          style: const TextStyle(color: Colors.orange),
        ),
      ),
    );
  }
}
