import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/page/component.dart';
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
            Text("Forgot Password", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight:FontWeight.w500),),
            SizedBox(height: 50,),
            Text("Please enter your email and we will send \nyou a link to return your account"),
            SizedBox(height: 25,),
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
            SizedBox(height: 30,),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: StadiumBorder(),
                ),
                icon: Icon(Icons.send),
                label: Text("Continue"),
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
            SizedBox(height: 30,),
            ButtonWidget(context: context, width: 200, height: 48, icon: Icons.logout, label: "Back", press: () => Navigator.of(context).pop(),)
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
  }
  _save(BuildContext context) {
    if (formState.currentState!.validate()){
      formState.currentState!.save();
    }
  }

}
