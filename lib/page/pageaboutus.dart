import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'component.dart';

class PageAboutUs extends StatelessWidget {
  const PageAboutUs({Key? key}) : super(key: key);

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
              "About Us",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/jewel_shop.png",
              height: ScreenSize.getScreenHeight(context) * 0.2,
            ),
            SizedBox(height: ScreenSize.getScreenHeight(context) * 0.001,),
            Text(
              "WE ARE TEAM PARASITE",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                description,
                textAlign: TextAlign.justify,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.5),
              child: Text(
                "Instructor: Mr. Huỳnh Tuấn Anh\n"
                    "Logo designer: Đậu Thanh Nga\n"
                    "Pub.dev\n"
                    "Youtuber - The Flutter Way\n"
                    "chatGPT - OpenAI\n"
                    "Stackoverflow - Christopher Moore\n",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Finally, thank you for visiting our Jewel Shop. "
                    "If you have any questions or need assistance, "
                    "please don't hesitate to contact us. "
                    "We are more than happy to help you!\n\n"
                    "Our Members:",
                textAlign: TextAlign.justify,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 5.5, 15, 15),
              child: Text(
                "Nguyễn Dương Anh Tuấn - 62133366\n"
                    "Nguyễn Tuấn Kiệt - 62130890\n"
                    "Nguyễn Sanh Quốc Huy - 62130757\n"
                    "Nguyễn Đăng Khoa - 62130863",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
