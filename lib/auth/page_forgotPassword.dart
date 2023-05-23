// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/auth/page_register.dart';

class PageForgotPassword extends StatelessWidget {
  PageForgotPassword({Key? key}) : super(key: key);

  final TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Forgot Password", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight:FontWeight.w500),),
            const SizedBox(height: 50,),
            const Text("Please enter your email and we will send \nyou a link to return your account"),
            const SizedBox(height: 25,),
            Form(
              key:formState,
              autovalidateMode: AutovalidateMode.disabled,
              child: BuildTextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                validator: (value) => _validateEmail(value),
                label: "Email",
                icon: Icons.email_rounded,
                obscureText: false,
                suffixIcon: null,
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const StadiumBorder(),
                ),
                icon: const Icon(Icons.send),
                label: const Text("Continue"),
                onPressed: () async {
                  _save(context);
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: txtEmail.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Đã gửi yêu cầu reset mật khẩu đến email của bạn"),
                      ),
                    );
                  }
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const StadiumBorder(),
                ),
                icon: const Icon(Icons.logout),
                label: const Text("Back"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty){
      return "Please enter your email" ;
    }
    else if (!value.contains("@") || !value.contains(".")){
      return "Please enter a valid email";
    }
    return null;
  }
  _save(BuildContext context) {
    if (formState.currentState!.validate()){
      formState.currentState!.save();
    }
  }

}
