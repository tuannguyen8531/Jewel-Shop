import 'package:flutter/material.dart';

List<GemType> gems = [
  GemType(title: "Diamond", icon: "assets/images/diamond.png", press: () {}),
  GemType(title: "Ruby", icon: "assets/images/ruby.png", press: () {}),
  GemType(title: "Sapphire", icon: "assets/images/sapphire.png", press: () {}),
  GemType(title: "Emerald", icon: "assets/images/emerald.png", press: () {}),
  GemType(title: "Other", icon: "assets/images/other.png", press: () {}),
];

class GemType {
  String title;
  String icon;
  VoidCallback press;
  GemType({required this.title, required this.icon, required this.press});
}
