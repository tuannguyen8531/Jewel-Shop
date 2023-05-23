import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/page/pagecart.dart';
import 'package:jewel_project/page/pagehome.dart';
import 'package:jewel_project/page/pagelistall.dart';
import 'package:jewel_project/page/pageuserinfo.dart';

import '../auth/page_login.dart';

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
          MenuTitle(title: "Home", icon: Icons.home_filled, destination: PageHome(),),
          MenuTitle(title: "Products", icon: Icons.diamond, destination: const PageList(),),
          MenuTitle(title: "Cart", icon: Icons.shopping_cart, destination: const PageCart(),),
          MenuTitle(title: "Search", icon: Icons.search,),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          MenuTitle(title: "User Info", icon: Icons.account_box, destination: const PageUserInfo(),),
          MenuTitle(title: "About Us", icon: Icons.message_outlined,),
          const SizedBox(height: 350,),
          Column(
            children: [
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => PageLogin()), (route) => false);
                },
                leading: const SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(Icons.logout, color: Colors.orange,),
                ),
                title: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          )
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

