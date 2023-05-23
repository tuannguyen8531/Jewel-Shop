import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.press,
  }) : super(key: key);
  String name, price, image;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 1,
        shadowColor: Colors.blue,
        child: Column(
          children: [
            Image.network(
              image,
              height: 180,
            ),
            Text(name),
            Text(
              "\$$price",
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({
    Key? key,
    required this.icon,
    required this.type,
    required this.press,
  }) : super(key: key);
  String icon;
  String type;
  VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: press,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Image.network(
                icon,
                height: 50,
              ),
              const SizedBox(height: 5),
              Text(
                type,
                style: const TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
