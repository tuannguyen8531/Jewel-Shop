import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text("Zen Edward"),
            accountEmail: Text("zenedward.123@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
            ),
          ),
        ],
      ),
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
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        role,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
