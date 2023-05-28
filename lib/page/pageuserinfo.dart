import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/data/user_data.dart';
import 'package:jewel_project/page/pageupdateinfo.dart';

import 'component.dart';


class PageUserInfo extends StatelessWidget {
  const PageUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.add, color: Colors.transparent,),
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
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.transparent,),
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
                String currentInfo;
                if(FirebaseAuth.instance.currentUser!.email==null) {
                  currentInfo = FirebaseAuth.instance.currentUser!.phoneNumber!;
                }
                else {
                  currentInfo = FirebaseAuth.instance.currentUser!.email!;
                }
                for(var user in list) {
                  if(user.user.email==currentInfo || user.user.phone==currentInfo) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: ScreenSize.getScreenWidth(context) * 0.032,),
                              SizedBox(
                                width: ScreenSize.getScreenWidth(context) * 0.286,
                                height: ScreenSize.getScreenHeight(context) * 0.128,
                                child: const CircleAvatar(
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
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => PageEditInfo(userSnapshot: user),),
                                  );
                                },
                              ),
                              const SizedBox(height: 50,),
                              const Divider(),
                              const SizedBox(height: 10,),
                              ProfileMenuTitle(
                                  text: user.user.name,
                                  icon: Icons.person
                              ),
                              const Divider(),
                              ProfileMenuTitle(
                                  text: user.user.age.toString(),
                                  icon: Icons.cake_outlined
                              ),
                              const Divider(),
                              ProfileMenuTitle(
                                  text: user.user.phone,
                                  icon: Icons.phone
                              ),
                              const Divider(),
                              ProfileMenuTitle(
                                  text: user.user.email,
                                  icon: Icons.email_outlined
                              ),
                              const Divider(),
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
                return const Center(child: CircularProgressIndicator());
              }
            }
          },
        ),
    );
  }
}





