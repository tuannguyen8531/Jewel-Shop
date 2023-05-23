// ignore_for_file: use_build_context_synchronously

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jewel_project/page/pagehome.dart';


class PageRegister extends StatefulWidget {

   const PageRegister({Key? key}) : super(key: key);

  @override
  State<PageRegister> createState() => _PageRegisterState();
}
class _PageRegisterState extends State<PageRegister> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool togglePass = true; // dùng để ẩn hiện password
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            children: [
                Image.asset("assets/images/jewel_shop.png", height: 220 ,),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 20,
                      height: 1.5,
                  ),
                ),
                const SizedBox(height: 30,),
                Form(
                  key:formState,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      BuildTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: txtEmail,
                        validator: (value) => _validateEmail(value),
                        label: "Email",
                        icon: Icons.email_rounded,
                        obscureText: false,
                        suffixIcon: null,
                      ),
                      const SizedBox(height: 15,),
                      BuildTextFormField(
                        keyboardType: TextInputType.text,
                        controller: txtPassword,
                        validator: (value) => _validatePassword(value),
                        label: "Password",
                        icon: Icons.lock,
                        obscureText: togglePass, // obscrureText dùng để ẩn hiện, ban đầu obscrureText = false thì sẽ ẩn pass
                        suffixIcon: IconButton(
                          // Khi click sẽ vẽ lại giao diện và chuyển đổi giá trị togglePass
                          onPressed: () {
                            setState(() {
                              togglePass = !togglePass;
                            });
                          },
                          // ban đầu toggle = false thì sẽ hiển thị icon mở mắt
                          icon:  Icon(
                              togglePass ? Icons.visibility : Icons.visibility_off
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      BuildTextFormField(
                        keyboardType: TextInputType.text,
                        controller: txtConfirmPassword,
                        validator: (value) => _validateConfirmPassword(value),
                        label: "Confirm Password",
                        icon: Icons.lock,
                        obscureText: true,
                        suffixIcon: null,
                      ),
                    ],
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
                    icon: const Icon(Icons.key),
                    label: const Text("Sign Up"),
                    onPressed: () async {
                        _save(context);
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: txtEmail.text,
                          password: txtPassword.text
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              const SizedBox(height: 30,),
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.black, height: 1.5,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text("Or"),
                  ),
                  Expanded(child: Divider(color: Colors.black, height: 1.5,)),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      signInWithGoogle();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black12
                          ),
                          shape: BoxShape.circle
                      ),
                      child:  Image.asset("assets/images/google.png" , height: 40,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      signInWithFacebook();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black12
                          ),
                          shape: BoxShape.circle
                      ),
                      child:  Image.asset("assets/images/facebook.png" , height: 40,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? phoneNumber = "+1 650-555-1234";
                      signInWithPhoneNumber(
                          context, phoneNumber: phoneNumber,
                          timeOut: 60,
                          smsTesCode: "123456",
                          smsCodePrompt: () =>
                              showPromtSMSCodeInput(context),
                          onSigned: () =>
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => PageHome(),
                                  ),
                                    (route) => false,
                              ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black12
                          ),
                          shape: BoxShape.circle
                      ),
                      child:  const Icon(Icons.phone, size: 30,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 15,),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Login", style: TextStyle(color: Colors.orange),),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
  _save(BuildContext context) {
    if (formState.currentState!.validate()){
      formState.currentState!.save();
    }
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
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty){
      return "Please enter your password";
    }
    else if (value.length <8){
      return "Password too short \nLength of password characters must be 8 \nor greater";
    }
    return null;
  }
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty){
      return "Please enter your password" ;
    }
    else if (value != txtPassword.text) {
      return "Password mismatch ";
    }
    return null;
  }

  void signInWithGoogle() async{
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential)
        .then((value){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageHome(),), (route) => false);
    } );
  }
  void signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)
        .then((value){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageHome(),), (route) => false);
    } ).catchError((onError){
    } );
  }

  void signInWithPhoneNumber(BuildContext context, { void Function()? onSigned, String? signIningMessage, String? signedMessage,
    Future<String?> Function()? smsCodePrompt, int timeOut = 30, required phoneNumber, String? smsTesCode
  } ) {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: timeOut),
      verificationCompleted: (phoneAuthCredential)async {

      },
      verificationFailed: (error) {

      },
      codeSent: (verificationId, forceResendingToken) async {
        String? smsCode = smsTesCode;
        if(smsCodePrompt!=null) {
          smsCode = await smsCodePrompt();
        }
        if(smsCode!=null){
          var credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: smsCode
          );
          try {
            var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
            if(onSigned!=null) {
              onSigned();
            }
          } on FirebaseAuthException catch(e){
            print(e);
          }
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
      },
    );
  }

  Future<String?> showPromtSMSCodeInput(BuildContext context) async {
    TextEditingController sms =TextEditingController();
    AlertDialog dialog = AlertDialog(
      title: const Text("Enter SMS Code"),
      content: TextField(
        controller: sms,
        decoration: const InputDecoration(
          labelText: "SMS Code",
        ),
        keyboardType: TextInputType.phone,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(null),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(sms.text),
          child: const Text("OK"),
        ),
      ],
    );
    String? res = await showDialog<String?>(
      barrierDismissible: false,
      context: context,
      builder: (context) => dialog,
    );
    return res;
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

