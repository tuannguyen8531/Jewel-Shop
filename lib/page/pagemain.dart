import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jewel_project/auth/page_login.dart';
import 'package:jewel_project/page/component.dart';
import 'package:jewel_project/page/pageaboutus.dart';
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
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    String? temp;
    // Nếu đăng nhập bằng email, phone = null thì hiển thị email của user hiện tại
    if(widget.phone==null) {
      temp = FirebaseAuth.instance.currentUser!.email!;
    }
    // Không thì hiển thị số điện thoại
    else {
      temp = widget.phone;
    }
    return Scaffold(
      drawer: Drawer(
        width: ScreenSize.getScreenWidth(context) * 0.8,
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
            ListTile(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageAboutUs(),),
                );
              },
              leading: const SizedBox(
                height: 34,
                width: 34,
                child: Icon(Icons.message_outlined, color: Colors.orange,),
              ),
              title: const Text(
                "About Us",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            SizedBox(height: ScreenSize.getScreenHeight(context) * 0.35,),
            // Nút logout
            Column(
              children: [
                ListTile(
                  onTap: () async {
                    final result = await showConfirmDialog(
                        context,
                        "Log Out",
                        "Are you sure want to log out?"
                    );
                    if(result) {
                      // Nếu Ok thì đăng xuất tài khoản
                      showSnackBar(context, "Logged out successfully!", 2);
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const PageLogin()), (route) => false
                      );
                    }
                    else {
                      // Không thì không làm gì hết
                      return;
                    }
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
            onPressed: () {
              showSnackBar(context, "Feature is under development!", 2);
            },
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

  ListTile buildListTileMenu(BuildContext context, IconData icon,String title, int index) {
    return ListTile(
      onTap: () {
        setState(() {
          currentIndex=index; // Cập nhật giá trị biến trung gian khi nhấn vào danh mục
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


