import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jewel_project/auth/page_login.dart';
import 'package:jewel_project/page/component.dart';
import 'package:jewel_project/page/pagecart.dart';
import 'package:jewel_project/page/pagehome.dart';
import 'package:jewel_project/page/pagelistall.dart';
import 'package:jewel_project/page/pageuserinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageMain extends StatefulWidget {

  final String name;
  final String? phone;

  @override
  State<PageMain> createState() => _PageMainState();

  const PageMain({super.key,
    required this.name,
    this.phone,
  });
}

class _PageMainState extends State<PageMain> {
  List screen = [
    PageHome(),
    const PageList(icon: BackNull(),),
    const PageCart(icon: BackNull(),),
    const PageUserInfo()
  ];
  int currentIndex=0, drawerIndex=0;
  @override
  Widget build(BuildContext context) {
    String? temp;
    if(widget.phone==null) {
      temp = FirebaseAuth.instance.currentUser!.email!;
    }
    else {
      temp = widget.phone;
    }
    return Scaffold(
      drawer: Drawer(
        width: 333,
        backgroundColor: Colors.white,
        elevation: 0,
        child: Column(
          children: [
            InfoCard(name: widget.name, email: temp!),
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
                buildListTileMenu(context,Icons.home_filled, "Home", 0),
                buildListTileMenu(context,Icons.diamond, "Product", 1),
                buildListTileMenu(context,Icons.shopping_cart, "Cart", 2),
                buildListTileMenu(context,Icons.search, "Search", 0),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            buildListTileMenu(context,Icons.account_box, "User Info", 3),
            buildListTileMenu(context,Icons.message, "About Us", 0),
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
      ),
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

      body: screen[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: GNav(
          backgroundColor: Colors.white30,
          tabBackgroundColor: const Color.fromRGBO(250, 250, 79, 0.2),
          color: Colors.black87,
          activeColor:Colors.orange ,
          gap: 8,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: "Home",
            ),
            GButton(icon: Icons.diamond, text: "Product",),
            GButton(icon: Icons.shopping_cart, text: "Cart",),

            GButton(icon: Icons.person_sharp, text: "Profile",),
          ],
          selectedIndex: currentIndex,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },

        ),
      ),
    );
  }

  ListTile buildListTileMenu(BuildContext context, IconData icon,String title, int press ) {
    return ListTile(
                onTap: () {
                  setState(() {
                    currentIndex=press; // Cập nhật giá trị biến trung gian khi nhấn vào danh mục
                  });
                  Navigator.pop(context); // Đóng Drawer
                },
                leading:  SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(icon, color: Colors.orange,),
                ),
                title:  Text(
                  title,
                  style: const TextStyle(color: Colors.orange),
                ),
              );
  }
}


