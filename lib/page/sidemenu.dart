import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/page/pagecart.dart';
import 'package:jewel_project/page/pagehome.dart';
import 'package:jewel_project/page/pagelistall.dart';
import 'package:jewel_project/page/pageuserinfo.dart';

import '../auth/page_login.dart';
import 'component.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key,
    required this.email,
  });
  String email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 333,
      backgroundColor: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          InfoCard(name: "Zen", email: email),
          const SizedBox(height: 15,),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return PageHome();
                    },),
                  );
                },
                leading: const SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(Icons.home_filled, color: Colors.orange,),
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
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
          const SizedBox(height: 300,),
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
          ),
        ],
      ),
    );
  }
}



