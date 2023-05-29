import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jewel_project/auth/page_forgot_password.dart';
import 'package:jewel_project/auth/page_register.dart';
import 'package:jewel_project/data/user_data.dart';
import 'package:jewel_project/page/component.dart';
import 'package:jewel_project/data/widget_connect_firebase.dart';
import 'package:jewel_project/page/pagemain.dart';


// App tạo kết nối đến Firebase, kết nối thành công sẽ chuyển đến PageLogin
class JewelApp extends StatelessWidget {
  const JewelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnection(
        builder: (context) => const PageLogin(),
        errorMessage: "Error!",
        connectingMessage: "Connecting..."
    );
  }
}

// Trang đăng nhập
class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  // Key của form để lưu trạng thái của form
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // Các controller của các Text input
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  // Các biến để kiểm tra email và pass trên Firebase
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
                  const Text("Login", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20, height: 1.5),),
                  const SizedBox(height: 30,),
                  Form(
                      key:formState,
                      // Tắt tự động xác thực
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          // Widget input bên component.dart
                          TextFormFieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            controller: txtEmail,
                            // Kiểm tra có đúng định dạng email không
                            validator: (value) => _validateEmail(value),
                            label: "Email",
                            icon: Icons.email_rounded,
                            // obscrureText dùng để ẩn hiện, ban đầu obscrureText = false thì sẽ hiện email
                            obscureText: false,
                            // suffixIcon là icon phía sau input
                            suffixIcon: null,
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 25,
                            // Hiển thị email có trên Firebase chưa
                            child: validateEmail=="" ? null : const Text("Please check your email again", style: TextStyle(color: Colors.red),),
                          ),
                          const SizedBox(height: 10,),
                          TextFormFieldWidget(
                            keyboardType: TextInputType.text,
                            controller: txtPassword,
                            // Kiểm tra pass có hợp lệ
                            validator: (value) => _validatePassword(value),
                            label: "Password",
                            icon: Icons.lock,
                            // obscrureText dùng để ẩn hiện, ban đầu obscrureText = true thì sẽ ẩn pass
                            obscureText: true,
                            suffixIcon: null,
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 25,
                            // Hiển thị pass có trên Firebase chưa
                            child: validatePassword=="" ? null : const Text("Please check your password again", style: TextStyle(color: Colors.red),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PageForgotPassword(),));
                                  },
                                  child: const Text("Forgot Password?", style:TextStyle(color: Colors.orange),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          ButtonWidget(context: context, width: 200, height: 48, icon: Icons.login, label: "Log In", press: () => signInWithEmail(),)
                        ],
                      )
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
                          child:  const Icon(Icons.phone, size: 30,),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 15,),
                      TextButton(
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const PageRegister(),)),
                        child: const Text("Sign Up", style: TextStyle(color: Colors.orange),),
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
    // Thử đăng nhập bằng email
    try {
      showSnackBar(context, "Logging in...", 1);
      // Đăng nhập bằng email và pass
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txtEmail.text,
        password: txtPassword.text,
      );
      // Trong try đã đang nhập thành công
      // Thực hiện lấy danh sách người dùng trên firebase về
      // Chuyển danh sách người dùng từ Stream<List> về <List> bằng hàm
      // convertStreamToList(Stream<List>) => List<>
      convertStreamToList(UserSnapshot.getAllUser()).then((resultList) {
        // Chuyển thành công, resultList là List<UserSnapshot>
        // Biến kiểm tra thông tin tài khoản đăng nhập đã có trong bảng users chưa
        bool hasInfo = false;
        String temp = "Customer";
        // Chạy vòng lặp kiểm tra
        for(UserSnapshot userSnapshot in resultList) {
          // Nếu email nhập vào có trong bảng users
          if(userSnapshot.user.email == txtEmail.text) {
            temp = userSnapshot.user.name;
            hasInfo = true;
            break;
          }
        }
        // Nếu có rồi thì chạy thẳng vào PageMain
        if(hasInfo) {
          showSnackBar(context, "Logged in successfully!", 2);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PageMain(name: temp,)),
                (route) => false,
          );
        }
        // Nếu không thì tạo người dùng mới, thêm vào bảng users rồi mới vào PageMain
        else {
          UserItem newUser = UserItem(
            id: "",
            name: "Customer",
            address: "",
            email: txtEmail.text,
            phone: "",
            isUpdated: false,
            age: 0,
          );
          UserSnapshot.add(newUser);
          showSnackBar(context, "Logged in successfully!", 2);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PageMain(name: temp,)),
                (route) => false,
          );
        }
      }).catchError((error) {});
    } on FirebaseAuthException catch (e) {
      // Lỗi không có tài khoản email trên firebase
      if (e.code == 'user-not-found') {
        setState(() {
          validateEmail="Incorrect Email";
        });
      } else if (e.code == 'wrong-password') {
        // Mật khẩu không đúng
        setState(() {
          validateEmail= "";
          validatePassword = "Password incorrect";
        });
      }
      else if (e.code != 'wrong-password'){
        // Một lỗi khác khác lỗi sai mật khẩu
        setState(() {
          validatePassword = "";
        });
      }
    }
     catch (e) {
      print('Lỗi khi đăng nhập: $e');
    }
    // Gọi hàm kiểm tra tính hợp lệ của form
    _save(context);

  }
  void signInWithGoogle() async{
        // Tạo đối tượng đăng nhập
        GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        // Lấy thông tin xác thực từ yêu cầu đăng nhập Google
        GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
        // Đăng nhập bằng token
        var credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        FirebaseAuth.instance.signInWithCredential(credential).then((value){
          // Đăng nhập thành công
          convertStreamToList(UserSnapshot.getAllUser()).then((resultList) {
            bool hasInfo = false;
            String temp = googleUser.displayName!;
            for(UserSnapshot user in resultList) {
              print(user.user.email);
              if(user.user.email == googleUser.email) {
                hasInfo = true;
                break;
              }
            }
            // Nếu có rồi thì chạy thẳng vào Home
            if(hasInfo) {
              showSnackBar(context, "Logged in successfully!", 2);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => PageMain(name: temp,)),
                    (route) => false,
              );
            }
            // Nếu không thì tạo người dùng mới, thêm vào firebase rồi mới vào Home
            else {
              UserItem newUser = UserItem(
                id: "",
                name: temp,
                address: "",
                email: googleUser.email,
                phone: "",
                isUpdated: false,
                age: 0,
              );
              UserSnapshot.add(newUser);
              showSnackBar(context, "Logged in successfully!", 2);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => PageMain(name: temp,)),
                    (route) => false,
              );
            }
          }).catchError((error) {
            print(error);
          });
        } );
  }

  // Hiển thị dialog nhập số điện thoại
  void showDialogPhone(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text("Enter your phone", textAlign: TextAlign.center,),
      content:
          TextFormFieldWidget(
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
            Navigator.of(context).pop();
            signInWithPhoneNumber(
                context, phoneNumber: txtPhone.text,
                timeOut: 60,
                smsTesCode: "123456",
                smsCodePrompt: () => showPromtSMSCodeInput(context),
                onSigned: (){
                  convertStreamToList(UserSnapshot.getAllUser()).then((resultList) {
                    bool hasInfo = false;
                    String temp = "Customer";
                    for(UserSnapshot user in resultList) {
                      if(user.user.phone == txtPhone.text) {
                        hasInfo = true;
                        break;
                      }
                    }
                    // Nếu có rồi thì chạy thẳng vào Home
                    if(hasInfo) {
                      showSnackBar(context, "Logged in successfully!", 2);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PageMain(name: "Customer", phone: FirebaseAuth.instance.currentUser!.phoneNumber,),),(route) => false);
                    }
                    // Nếu không thì tạo người dùng mới, thêm vào firebase rồi mới vào Home
                    else {
                      UserItem newUser = UserItem(
                        id: "",
                        name: temp,
                        address: "",
                        email: txtPhone.text,
                        phone: txtPhone.text,
                        isUpdated: false,
                        age: 0,
                      );
                      UserSnapshot.add(newUser);
                      showSnackBar(context, "Logged in successfully!", 2);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PageMain(name: "Customer", phone: FirebaseAuth.instance.currentUser!.phoneNumber,),),(route) => false);
                    }
                  }).catchError((error) {
                    print(error);
                  });
                },
            );

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

  // Đăng nhập bằng Facebook
  void signInWithFacebook() async {
        // Trigger the sign-in flow
        final LoginResult loginResult = await FacebookAuth.instance.login();
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
        // Once signed in, return the UserCredential
         await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)
             .then((value){
           showSnackBar(context, "Logged in successfully!", 2);
           Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(builder: (context) => const PageMain(name: "Customer",),), (route) => false);
         } ).catchError((onError){
           print(onError);
         } );
  }

  void signInWithPhoneNumber(BuildContext context, { void Function()? onSigned, String? signIningMessage, String? signedMessage,
    Future<String?> Function()? smsCodePrompt, int timeOut = 30, required phoneNumber, String? smsTesCode
  }) {
    // Đăng nhập bằng số điện thoại
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // Thời gian tồn tại xác thực
        timeout: Duration(seconds: timeOut),
        verificationCompleted: (phoneAuthCredential)async {},
        verificationFailed: (error) {},
        // Khi đã kiểm tra đúng số điện thoại, gửi code xác thực
        codeSent: (verificationId, forceResendingToken) async {
          print("Verification ID: $verificationId");
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
                await FirebaseAuth.instance.signInWithCredential(credential);
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

  // Hiển thị dialog nhập SMS code
  Future<String?> showPromtSMSCodeInput(BuildContext context) async {
    TextEditingController sms =TextEditingController();
    AlertDialog dialog =AlertDialog(
      title: const Text("Enter SMS Code",textAlign: TextAlign.center),
      content: TextFormFieldWidget(
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

  // Các hàm điều kiện tra tính hợp lệ
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
    return null;
  }

  // Hàm kiểm tra tính hợp lệ của form
  _save(BuildContext context) {
    if (formState.currentState!.validate()){
      formState.currentState!.save();
    }
  }

}


// Hàm chuyển đổi Strem<List<Item>> thành List<Item>
// Hàm bất đồng bộ trả về Future<List<Item>> đầu tiên của Stream.
Future<List<UserSnapshot>> convertStreamToList(Stream<List<UserSnapshot>> stream) async  {
  return await stream.first;
}







