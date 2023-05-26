import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/page/dialogconfirm.dart';

import 'component.dart';


class PageUserInfo extends StatelessWidget {
  const PageUserInfo({Key? key}) : super(key: key);

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
              "Profile",
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/background.png"),
                  ),
                ),
                const SizedBox(height: 12,),
                Text(
                  "Zen Edward",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "zen.edward.7@gmail.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12,),
                ButtonWidget(
                  context: context,
                  width: 200,
                  height: 48,
                  icon: Icons.edit,
                  label: "Edit profile",
                  press:() {
                    showConfirmDialog(context, "Edit Info");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



