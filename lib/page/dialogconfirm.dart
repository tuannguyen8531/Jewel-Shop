
import 'package:flutter/material.dart';
import 'component.dart';

Future<bool> showConfirmDialog(BuildContext context, String title) async{
  bool result = false;
  var dialog = AlertDialog(
    title:Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange,
      ),
      child:
      Padding(
        padding: const EdgeInsets.only(left:5, bottom: 5, right: 5, top:5), //apply padding to some sides only
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
    content: SizedBox(
      height: 100,
      width: 333,
      child: Column(
        children: const [
          Text("Are you sure want to pay all the products in your cart?"),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWidget(
            context: context,
            width: 155,
            height: 40,
            icon: Icons.verified_user,
            label: "OK",
            press: () {
              result = true;
              Navigator.of(context).pop(result);
            },
          ),
          ButtonWidget(
            context: context,
            width: 155,
            height: 40,
            icon: Icons.cancel,
            label: "Cancel",
            press: () {
              result = false;
              Navigator.of(context).pop(result);
            },
          ),
        ],
      ),
    ],
  );

  result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => dialog,
  ) ?? false;
  return result;
}

