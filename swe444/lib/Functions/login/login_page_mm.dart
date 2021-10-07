import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe444/Functions/home_screen/mm_home_view.dart';
// import 'package:swe444/Views/mm_home_view.dart';
// import 'package:swe444/Views/signup_login_screen_mm.dart';
// import 'package:swe444/Views/v_home_view.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
import '../signup_login_screen.dart';
import 'reset_password.dart';

class mLoginPage extends StatefulWidget {
  final Function(User) onSignIn;

  mLoginPage({required this.onSignIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<mLoginPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  static const kYellow = const Color(0xdeedd03c);
  String errorMessage = '';
  Snackbar? snackbar;
  static const firebaseErrors = {
    'auth/user-not-found': 'No user corresponding to this email',
    'auth/email-already-in-use': 'The email address is already in use',
  }; // list of firebase error codes to alternate error messages
  String? error = "";
  bool isLogin = true;

  Future<void> login() async {
    if (_controllerEmail.text.isNotEmpty && _controllerPass.text.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _controllerEmail.text, password: _controllerPass.text);
        print(userCredential.user);
        widget.onSignIn(userCredential.user!);
        //
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            setState(() {
              errorMessage = 'البريد الالكتروني غير صحيح';
            });
            break;

          case "wrong-password":
            setState(() {
              errorMessage = 'كلمة السر غير صحيحة';
            });
            break;

          case "user-not-found":
            setState(() {
              errorMessage = 'لايوجد مستخدم مسجل بهذا الحساب في تطبيق إمْداد';
            });
            break;

          case "requires-recent-login":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;

          case "too-many-requests":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;

          case "operation-not-allowed":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;

          case "network-request-failed":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;

          case "credential-already-in-use":
            setState(() {
              errorMessage =
                  'بيانات الاعتماد هذه مرتبطة بالفعل بحساب مستخدم مختلف';
            });
            break;

          case "user-disabled":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;

          case "user-disabled":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;

          default:
            setState(() {
              errorMessage = 'حدث خطأ ما ، أعد المحاولة من فضلك';
            });
            break;
        }

        snackbar = Snackbar(context, errorMessage);
        snackbar!.showToast();

        setState(() {
          error = errorMessage;
        });
      } catch (e) {
        String ourE = e.toString();

        setState(() {
          error = ourE;
        });
      }
    } //end if

    if (_controllerEmail.text.isEmpty && _controllerPass.text.isEmpty) {
      errorMessage = "الرجاء إدخال البريد الالكتروني وكلمة السر ";
    } else if (_controllerEmail.text.isEmpty) {
      errorMessage = " الرجاء إدخال البريد الالكتروني ";
    } else if (_controllerPass.text.isEmpty) {
      errorMessage = "الرجاء إدخال كلمة السر ";

      switch ("invalid-email") {
        case "invalid-email":
          errorMessage += 'البريد الالكتروني غير صحيح';

          break;

        case "wrong-password":
          errorMessage += 'كلمة السر غير صحيحة';

          break;

        case "user-not-found":
          setState(() {
            errorMessage = 'لايوجد مستخدم مسجل بهذا الحساب في تطبيق إمْداد';
          });
          break;

        case "requires-recent-login":
          setState(() {
            errorMessage =
                'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
          });
          break;

        case "too-many-requests":
          setState(() {
            errorMessage =
                'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
          });
          break;

        case "operation-not-allowed":
          setState(() {
            errorMessage =
                'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
          });
          break;

        case "network-request-failed":
          setState(() {
            errorMessage =
                'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
          });
          break;

        case "credential-already-in-use":
          setState(() {
            errorMessage =
                'بيانات الاعتماد هذه مرتبطة بالفعل بحساب مستخدم مختلف';
          });
          break;

        case "user-disabled":
          setState(() {
            errorMessage =
                'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
          });
          break;

        case "user-disabled":
          setState(() {
            errorMessage =
                'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
          });
          break;

        default:
          setState(() {
            errorMessage = 'حدث خطأ ما ، أعد المحاولة من فضلك';
          });
          break;
      }

      snackbar = Snackbar(context, errorMessage);
      snackbar!.showToast();
    } //end 2ed switch
  } //end login

  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPass.text);
      print(userCredential.user);
      widget.onSignIn(userCredential.user!);
      //
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.toString();
        // bool login = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "تسجيل الدخول",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff334856),
            fontWeight: FontWeight.w700,
            fontFamily: 'Tajawal',
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xdeedd03c),
        bottomOpacity: 30,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignupLoginScreen()));
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
          )
        ],
        iconTheme: IconThemeData(
          // Padding(padding: EdgeInsets.only(right: 20.0)),

          color: Color(0xff334856), //change your color here.
        ),
      ),
      body: Container(
        padding: new EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                // showAlert(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                          height: 160,
                          width: 160,
                          child: Image.asset('images/logo.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.0, top: 55),
                      child: Text(
                        "مرحباً بك في",
                        style: TextStyle(
                          color: Color(0xff334856),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    showCursor: true,
                    cursorColor: const Color(0xdeedd03c),
                    textAlign: TextAlign.right,
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(
                          color: kYellow,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: const Color(0xff334856),
                      ),
                      prefixStyle: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      hoverColor: const Color(0xff334856),
                      hintText: 'أدخل البريد الالكتروني',
                      labelText: 'البريد الالكتروني',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff334856),
                          fontFamily: 'Tajawal'),
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: const Color(0xff334856),
                          fontFamily: 'Tajawal'),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    autocorrect: false,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    showCursor: true,
                    cursorColor: const Color(0xdeedd03c),
                    textAlign: TextAlign.right,
                    controller: _controllerPass,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(
                          color: const Color(0xdeedd03c),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: const Color(0xff334856),
                      ),
                      prefixStyle: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      hoverColor: const Color(0xff334856),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'أدخل كلمة السر',
                      labelText: 'كلمة السر',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff334856),
                          fontFamily: 'Tajawal'),
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: const Color(0xff334856),
                          fontFamily: 'Tajawal'),
                    ),
                    autocorrect: false,
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPasswordScreen()));
                      },
                      child: Text(
                        'هل نسيت كلمة السر؟',

                        // 'هل نسيت كلمة السر؟',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff334856),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xdeedd03c)),
                      minimumSize: MaterialStateProperty.all(Size(300, 64)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500),
                        ),
                      ),
                    ),
                    onPressed: () {
                      login();
                      Navigator.pushAndRemoveUntil(
                          (context),
                          MaterialPageRoute(builder: (context) => mmHome()),
                          (route) => false);
                    },
                    child: Text(
                      isLogin ? "تسجيل الدخول" : "التسجيل",
                      style: TextStyle(color: Color(0xff334856), fontSize: 20),
                    )),

                // RaisedButton(
                //     onPressed: () {
                //       isLogin ? login() : createUser();
                //     },
                //     child: Text(isLogin ? "تسجيل الدخول" : "التسجيل")),
                // OutlinedButton(
                //     onPressed: () {
                //       setState(() {
                //         isLogin = !isLogin;
                //       });
                //     },
                //     child: Text('Temp: Switch sign in/up'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//signUp

/*

Future<void> login() async {

    try{
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _controllerEmail.text, password: _controllerPass.text);
    print(userCredential.user);
   // widget.onSignIn(userCredential.user);
    //
    }

   on FirebaseAuthException catch (e){

setState(() {
  error = e.toString();
  bool login = true;
});


    }
  }
 */
