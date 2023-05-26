import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jewel_project/auth/page_forgotPassword.dart';
import 'package:jewel_project/auth/page_register.dart';
import 'package:jewel_project/page/component.dart';
import 'package:jewel_project/page/pagehome.dart';
import 'package:jewel_project/data/widget_connect_firebase.dart';


class JewelApp extends StatelessWidget {
  const JewelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnection(
        builder: (context) => PageLogin(),
        errorMessage: "Lỗi",
        connectingMessage: "Xe đạp ơi"
    );
  }
}


class PageLogin extends StatefulWidget {
  PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  String validateEmail="";
  String validatePassword="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/jewel_shop.png", height: 220 ,),
                  Text("Login", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20, height: 1.5),),
                  SizedBox(height: 30,),
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
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 25,
                            child: validateEmail=="" ? null : Text("Please check your email again", style: TextStyle(color: Colors.red),),
                          ),
                          SizedBox(height: 10,),
                          BuildTextFormField(
                            keyboardType: TextInputType.text,
                            controller: txtPassword,
                            validator: (value) => _validatePassword(value),
                            label: "Password",
                            icon: Icons.lock,
                            obscureText: true, // obscrureText dùng để ẩn hiện, ban đầu obscrureText = false thì sẽ ẩn pass
                            suffixIcon: null,
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 25,
                            child: validatePassword=="" ? null : Text("Please check your password again", style: TextStyle(color: Colors.red),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PageForgotPassword(),));
                                  },
                                  child: Text("Forgot Password?", style:TextStyle(color: Colors.orange),),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          ButtonWidget(context: context, width: 200, height: 48, icon: Icons.login, label: "Log In", press: () => signInWithEmail(),)
                        ],
                      )
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.black, height: 1.5,)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Text("Or"),
                      ),
                      Expanded(child: Divider(color: Colors.black, height: 1.5,)),
                    ],
                  ),
                  SizedBox(height: 30,),
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
                           //String? phoneNumber = "+1 650-555-1234";
                          showDialogPhone(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black12
                              ),
                              shape: BoxShape.circle
                          ),
                          child:  Icon(Icons.phone, size: 30,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 15,),
                      TextButton(
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => PageRegister(),)),
                        child: Text("Sign Up", style: TextStyle(color: Colors.orange),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
  void signInWithEmail  () async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txtEmail.text,
        password: txtPassword.text,
      );
      // Kiểm tra xem userCredential có khác null hay không
      if (userCredential != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageHome()),
              (route) => false,
        );
      } else {
        // UserCredential bằng null, tức là đăng nhập thất bại
        print('Đăng nhập không thành công');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          validateEmail="Email không đúng";
        });
      } else if (e.code == 'wrong-password') {
        // Mật khẩu không đúng
        setState(() {
          validateEmail="";
          validatePassword = "Password incorrect";
        });
      }
      else if (e.code != 'wrong-password'){
        setState(() {
          validatePassword = "";
        });
      }
    }
     catch (e) {
      print('Lỗi khi đăng nhập: $e');
    }
    _save(context);

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
          if (value!=null){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => PageHome(),), (route) => false);
          }
        } );
  }
  void showDialogPhone(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: Text("Enter your phone", textAlign: TextAlign.center,),
      content:
          BuildTextFormField(
            keyboardType: TextInputType.phone,
            controller: txtPhone,
            validator: (value) {
            },
            label: "Phone",
            icon: Icons.phone,
            obscureText: false,
            suffixIcon: null,
          ),
    actions: [
        ButtonWidget(
          context: context,
          width: 155,
          height: 40,
          icon: Icons.verified_user,
          label: "Verification",
          press: () {
            if (txtPhone.text != null) {
              Navigator.of(context).pop();
              signInWithPhoneNumber(
                  context, phoneNumber: txtPhone.text,
                  timeOut: 60,
                  smsTesCode: "123456",
                  smsCodePrompt: () => showPromtSMSCodeInput(context),
                  onSigned: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => PageHome(),),(route) => false)
              );
            }

          },
        ),
        ButtonWidget(
          context: context,
          width: 120,
          height: 40,
          icon: Icons.cancel,
          label: "Cancel",
          press: () => Navigator.of(context).pop(),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog,);

  }
  void signInWithFacebook() async {
        // Trigger the sign-in flow
        final LoginResult loginResult = await FacebookAuth.instance.login();
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
        // Once signed in, return the UserCredential
         await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)
             .then((value){
           if (value!=null){
             Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) => PageHome(),), (route) => false);
           }
         } ).catchError((onError){
           print(onError);
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
          print("Verification ID: $verificationId");
              String? smsCode = smsTesCode;
            if(smsCodePrompt!=null)
              smsCode = await smsCodePrompt();
            if(smsCode!=null){
              var credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: smsCode
              );
              try {
                var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                if(userCredential!=null){
                  if(onSigned!=null)
                    onSigned();
                }
              } on FirebaseAuthException catch(e){
              }
            }
        },
        codeAutoRetrievalTimeout: (verificationId) {
        },
    );
  }

  Future<String?> showPromtSMSCodeInput(BuildContext context) async {
    TextEditingController sms =TextEditingController();
    AlertDialog dialog =AlertDialog(
      title: Text("Enter SMS Code",textAlign: TextAlign.center),
      content: BuildTextFormField(
          keyboardType: TextInputType.phone,
          controller: sms,
          validator: (value) {},
          label: "SMS Code",
          icon: Icons.sms_outlined,
          obscureText: false,
          suffixIcon: null,
      ),
      actions: [
        ButtonWidget(context: context, width: 120, height: 40, icon: Icons.check, label: "OK", press: (){Navigator.of(context, rootNavigator: true).pop(sms.text);}),
        ButtonWidget(context: context, width: 120, height: 40, icon: Icons.cancel, label: "Cancel", press: (){Navigator.of(context, rootNavigator: true).pop(null);}),
      ],
    );
    String? res = await showDialog<String?>(
      barrierDismissible: false,
        context: context,
        builder: (context) => dialog,
    );
    return res;
  }


 String? _validateEmail(String? value) {
    if (value == null || value.isEmpty){
      return "Please enter your email" ;
    }
    else if (!value.contains("@") || !value.contains(".")){
      return "Please enter a valid email";
    }
  }
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty){
      return "Please enter your password";
    }
  }
  _save(BuildContext context) {
    if (formState.currentState!.validate()){
      formState.currentState!.save();
    }
  }

}






