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

class Gemstone {
  String image, name, price;
  Gemstone({required this.image, required this.name, required this.price});
}

List<Gemstone> gemstones = [
  Gemstone(
      image:
          "https://firebasestorage.googleapis.com/v0/b/jewel-project-17b95.appspot.com/o/Imagines%2FBlack%20Diamond.jpg?alt=media&token=7dc67906-f06f-4134-9bae-debf6503028e",
      name: "Black Diamond",
      price: "15000"),
  Gemstone(
      image:
          "https://firebasestorage.googleapis.com/v0/b/jewel-project-17b95.appspot.com/o/Imagines%2FHydrothermal%20Emerald.jpg?alt=media&token=8b3b7683-72b4-4e7a-b3e2-72a045278fe9",
      name: "Hydrothermal Emerald",
      price: "50000"),
  Gemstone(
      image:
          "https://firebasestorage.googleapis.com/v0/b/jewel-project-17b95.appspot.com/o/Imagines%2FCeylon%20Sapphire.jpg?alt=media&token=d0550d18-f7ba-4c6a-a806-5b849fd1a2b5",
      name: "Ceylon Sapphire",
      price: "22000"),
  Gemstone(
      image:
          "https://firebasestorage.googleapis.com/v0/b/jewel-project-17b95.appspot.com/o/Imagines%2FBaltic%20Amber.jpg?alt=media&token=ab0f1930-a203-4920-8762-47be1af892af",
      name: "Baltic Amber",
      price: "17000"),
  Gemstone(
      image:
          "https://firebasestorage.googleapis.com/v0/b/jewel-project-17b95.appspot.com/o/Imagines%2FPigeon%20Blood%20Ruby.jpg?alt=media&token=26b4cc5f-fec4-4b73-8b02-89d1efe83b6f",
      name: "Pigeon Blood",
      price: "9000"),
  Gemstone(
      image:
          "https://firebasestorage.googleapis.com/v0/b/jewel-project-17b95.appspot.com/o/Imagines%2FStar%20Ruby.jpg?alt=media&token=7c9db616-75ea-4fd8-893d-e8a94f7124d4",
      name: "Star Ruby",
      price: "37000"),
];

class User {
  String id, name, email, address, phone;
  bool isUpdated = false;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });
}

User user = User(id: "01", name: "Zen Edward", email: "zenedward.2002@gmail.com", address: "VN", phone: "0123456789");
