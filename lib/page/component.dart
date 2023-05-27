import 'package:flutter/cupertino.dart';
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

class ButtonWidget extends StatelessWidget {
  BuildContext context;
  double width, height;
  IconData icon;
  String label;
  VoidCallback press;
  ButtonWidget({super.key,
    required this.context,
    required this.width,
    required this.height,
    required this.icon,
    required this.label,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: const StadiumBorder(),
        ),
        icon: Icon(icon),
        label: Text(label),
        onPressed: press,
      ),
    );
  }
}

class BuildTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String?) validator;
  final String label;
  final IconData icon;
  final bool? obscureText;
  final IconButton? suffixIcon;
  const BuildTextFormField({
    super.key,
    this.suffixIcon,
    this.obscureText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        label: Text(label,style: const TextStyle(color: Colors.brown)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.orange),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(1, 1, 4, 1),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: Colors.deepOrange,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuTitle extends StatelessWidget {
  MenuTitle({super.key,
    required this.icon,
    required this.title,
    this.destination,
  });
  String title;
  IconData icon;
  Widget? destination;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if(destination!=null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destination!,),
              );
            }
            else {
              return;
            }
          },
          leading: SizedBox(
            height: 34,
            width: 34,
            child: Icon(icon, color: Colors.orange,),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({super.key,
    required this.name,
    required this.email,
  });
  String name, email;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,25,0,0),
      child: ListTile(
        leading: const CircleAvatar(
          maxRadius: 25,
          backgroundImage: AssetImage("assets/images/background.png"),
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.black87),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(color: Colors.black38),
        ),
      ),
    );
  }
}

class ProfileMenuTitle extends StatelessWidget {
  ProfileMenuTitle({
    super.key,
    required this.text,
    required this.icon,
  });
  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black54.withOpacity(0.1)
        ),
        child: Icon(icon),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
      trailing: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black54.withOpacity(0.1)
        ),
        child: const Icon(Icons.chevron_right_sharp),
      ),
    );
  }
}

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        CupertinoIcons.left_chevron,
        color: Colors.black,
      ),
    );
  }
}

class BackNull extends StatelessWidget {
  const BackNull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.add, color: Colors.transparent,);
  }
}

void showSnackBar(BuildContext context, String message, int second) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: second),)
  );
}

