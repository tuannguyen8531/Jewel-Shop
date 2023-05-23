
import 'package:flutter/material.dart';
import '../auth/page_register.dart';

void showConfirmDialog(BuildContext context){

  GlobalKey<FormState> formConfirm = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPhone = TextEditingController();

  saveInfor(BuildContext context){
    if(formConfirm.currentState!.validate()){
      formConfirm.currentState!.save();
    }
  }
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
              "Confirm Delivered",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    ),
    content:
    Container(
      height: 333,
      width: 333,
      child: Form(
        key: formConfirm,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:const EdgeInsets.symmetric(horizontal:10, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    BuildTextFormField(
                      keyboardType: TextInputType.text,
                      controller: txtName,
                      validator: (value) => validatName(value),
                      label: "Name",
                      icon: Icons.person,
                      obscureText: false,
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 30),
                    BuildTextFormField(
                      keyboardType: TextInputType.text,
                      controller: txtAddress,
                      validator: (value) => validateAddress(value),
                      label: "Address",
                      icon: Icons.place,
                      obscureText: false,
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 30),
                    BuildTextFormField(
                      keyboardType: TextInputType.number,
                      controller: txtPhone,
                      validator: (value) => validatePhone(value),
                      label: "Phone",
                      icon: Icons.phone,
                      obscureText: false,
                      suffixIcon: null,
                    ),
                  ],
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Background color
                    ),
                    onPressed: (){ saveInfor(context);},
                    child: const Text("Save"))
              ],
            ),
          ],
        ),
      ),
    ),
  );

  showDialog(context: context, builder: (context) => dialog);
}


String? validatName(String? s){
  return s == null || s.isEmpty ? "Enter your name" : null;
}

String? validateAddress(String? s){
  return s == null || s.isEmpty ? "Enter your address" : null;
}

String? validatePhone(String? s){
  return s == null || s.isEmpty ? "Enter your phone" : null;
}
String? validateEmail(String? s) {
  return s == null || s.isEmpty ? "Enter your email" :  null;
}
