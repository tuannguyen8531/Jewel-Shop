import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/data/user_data.dart';
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
      body: StreamBuilder<List<UserSnapshot>>(
        stream: UserSnapshot.getAllUser(),
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
              String currentEmail = FirebaseAuth.instance.currentUser!.email!;
              for(var user in list) {
                if(user.user.email==currentEmail) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 77,),
                            const SizedBox(
                              width: 120,
                              height: 120,
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/background.png"),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            Text(
                              user.user.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              user.user.email,
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
                            const SizedBox(height: 50,),
                            const Divider(thickness: 1,),
                            const SizedBox(height: 10,),
                            ProfileMenuTitle(
                                text: user.user.name,
                                icon: Icons.person
                            ),
                            const Divider(thickness: 1,),
                            ProfileMenuTitle(
                                text: user.user.phone,
                                icon: Icons.phone
                            ),
                            const Divider(thickness: 1,),
                            ProfileMenuTitle(
                                text: user.user.email,
                                icon: Icons.email_outlined
                            ),
                            const Divider(thickness: 1,),
                            ProfileMenuTitle(
                                text: user.user.address,
                                icon: Icons.home
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              return const CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}





