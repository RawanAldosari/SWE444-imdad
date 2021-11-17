import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../logout.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  String _title = "الملف الشخصي";
  bool _displayfirstname = true;
  bool _displaylastname = true;
  bool _displayemail = true;
  bool _displayphonnumber = true;
  RegExp regex = RegExp(r'^.{2,}$');
  RegExp regex2 =  RegExp(r'^.{6,}$');
  RegExp regex1 = RegExp(r'^((?:[0?5?]+)(?:\s?\d{8}))$');
  final auth = FirebaseAuth.instance;
  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');
  String _userFirstName = 'User NAme';
  String _userLastName = 'Last Name';
  late String _userEmail;
  String _userPhone = '05XXX';
  String role = '';
  String? mosqueName;
  String? mosqueCode;

  User? user() {
    return auth.currentUser;
  }

  getUserInformation() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        if (value.exists) {
          role = value.get('role');
          if (isVolunteer()) {
            if (value.data()!.containsKey('first_name') &&
                value.data()!.containsKey('last_name') &&
                value.data()!.containsKey('phone_number')) {
              _userFirstName = value.get('first_name');
              _userLastName = value.get('last_name');
              _userPhone = value.get('phone_number').toString();
            }
          } else {
            if (value.data()!.containsKey('mosque_name') &&
                value.data()!.containsKey('mosque_code') &&
                value.data()!.containsKey('phone_number')) {
              mosqueName = value.get('mosque_name');
              mosqueCode = value.get('mosque_code');
              _userPhone = value.get('phone_number').toString();
            }
          }
          print(value.data().toString());
        }
      });
    });
  }

  @override
  void initState() {
    if (auth.currentUser != null) {
      _userEmail = user()!.email ?? '';
      getUserInformation();
    }

    super.initState();
  }

  updateprofilefirstname() {}

  @override
  Widget build(BuildContext context) {
    final bold = TextStyle(fontWeight: FontWeight.bold);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffededed),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.0,
                      1.0
                    ],
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      Theme.of(context).accentColor.withOpacity(0.5),
                    ])),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "FlutterTutorial.Net",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.screen_lock_landscape_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Splash Screen',
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                //  title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                //  ),
                //   onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                //   },
                //  ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(Icons.person_add_alt_1,
                      size: _drawerIconSize,
                      color: Theme.of(context).accentColor),
                  title: Text(
                    'Registration Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {},
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.password_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Forgot Password Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    //   Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.verified_user_sharp,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Verification Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    //  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
              Container(
                //width: 250, // to wrap the text in multiline

                alignment: Alignment.centerRight,

                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    //Positioned.directional(textDirection: TextDirection.rtl, child: ,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        isVolunteer() ? Icons.person : Icons.account_balance,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(isVolunteer()?  "${_userFirstName} ${_userLastName}": "${mosqueName} ${mosqueCode}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    Text(
                      isVolunteer()
                          ? "${_userFirstName} ${_userLastName}"
                          : "مسجد " + "${mosqueName} ",
                      style: TextStyle(
                        fontSize: 22,
                        //  fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      isVolunteer() ? 'متطوع' : '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                            const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            //
                            alignment: Alignment.topRight,
                            child: Text(
                              "معلومات المستخدم",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Tajawal',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.topRight,

                              //   padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topRight,
                                      ),
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            enabled: isVolunteer(),
                                            onTap: () async {
                                              //  final text  = await showTextInputDialog(context: context, textFields: [DialogTextField()]);
                                              final text =
                                              await showTextInputDialog(
                                                context: context,
                                                title: ' الاسم الأول',
                                                textFields: [DialogTextField(
                                                  hintText: 'ادخل الاسم الاول ',
                                                  validator: (value){
                                                    RegExp regex = RegExp(r'^.{2,}$');
                                                    if (value!.isEmpty || value.trim().isEmpty) {
                                                      return ("الرجاء قم بإدخال اسمك الاول");
                                                    }
                                                    if (!regex.hasMatch(value)) {
                                                      return ("يجب ان يحتوي على حرفين على الأقل");
                                                    }
                                                    if (!RegExp(r"^[\p{L} ,.'-]*$",
                                                        caseSensitive: false, unicode: true, dotAll: true)
                                                        .hasMatch(value)) {
                                                      return ("يجب ان يحتوي الأسم الأول على أحرف فقط");
                                                    }
                                                    return null;
                                                  } ,

                                                )],
                                                okLabel: 'تأكيد',
                                                cancelLabel: 'الغاء',
                                              );

                                              if (text != null)
                                                setState(() {
                                                  _userFirstName = text[0];
                                                });
                                              //   _userFirstName.trim().isEmpty|| _userFirstName!.isEmpty && RegExp(r"^[\p{L} ,.'-]*$",
                                              //    caseSensitive: false, unicode: true, dotAll: true)
                                              //   .hasMatch( _userFirstName)&&!regex.hasMatch(_userFirstName)?_displayfirstname=false:_displayfirstname=true;

                                              if (_displayfirstname) {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(auth.currentUser!.uid)
                                                    .update(
                                                  //  {isVolunteer() ?'first_name':'mosque_name':text[0]}).then((value) {
                                                    {
                                                      'first_name': text![0]
                                                    }).then((value) {});
                                              }
                                            },
                                            leading: Icon(isVolunteer()
                                                ? Icons.person
                                                : Icons.account_balance),
                                            trailing: Icon(isVolunteer()
                                                ? Icons.edit
                                                : null),
                                            title: Text(
                                              isVolunteer()
                                                  ? "الاسم الاول "
                                                  : "اسم المسجد",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${isVolunteer() ? _userFirstName : mosqueName}",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                          ),

                                          ListTile(
                                              enabled: isVolunteer(),
                                              onTap: () async {
                                                // final text  = await showTextInputDialog(context: context, textFields: [DialogTextField()]);
                                                final text =
                                                await showTextInputDialog(
                                                    context: context,
                                                    title:
                                                    ' الاسم الأخير',
                                                    textFields: [
                                                      DialogTextField(
                                                          hintText: 'ادخل الاسم الاخير ',
                                                          validator: (value){
                                                            // return !regex.hasMatch(value!) ? 'يجب ان يكون ثلاث حروف أو أكثر ' : null;
                                                            RegExp regex = RegExp(r'^.{2,}$');
                                                            if (value!.isEmpty || value.trim().isEmpty) {
                                                              return ("الرجاء قم بإدخال اسم عائلتك");
                                                            }
                                                            if (!regex.hasMatch(value)) {
                                                              return ("يجب ان يحتوي على حرفين على الأقل");
                                                            }
                                                            if (!RegExp(r"^[\p{L} ,.'-]*$",
                                                                caseSensitive: false, unicode: true, dotAll: true)
                                                                .hasMatch(value)) {
                                                              return ("يجب ان يحتوي الأسم الأخير على أحرف فقط");
                                                            }
                                                            return null;
                                                          }
                                                      )
                                                    ],
                                                    okLabel: 'تأكيد',
                                                    cancelLabel: 'الغاء');

                                                //  _userLastName.trim().isEmpty|| _userLastName!.isEmpty && RegExp(r"^[\p{L} ,.'-]*$",
                                                //    caseSensitive: false, unicode: true, dotAll: true)
                                                //   .hasMatch( _userLastName)&&!regex.hasMatch(_userLastName)?_displaylastname=false:_displaylastname=true;
                                                if (text != null)
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(
                                                      auth.currentUser!.uid)
                                                      .update(
                                                    //    {isVolunteer() ?'last_name': 'mosque_code':text[0]}).then((value) {
                                                      {
                                                        'last_name': text[0]
                                                      }).then(
                                                        (value) {
                                                      setState(() {
                                                        _userLastName = text[0];
                                                      });
                                                    },
                                                  );
                                              },
                                              leading: Icon(isVolunteer()
                                                  ? Icons.person
                                                  : Icons.shield),
                                              trailing: Icon(isVolunteer()
                                                  ? Icons.edit
                                                  : null),
                                              title: Text(
                                                isVolunteer()
                                                    ? "الاسم الاخير "
                                                    : " كود المسجد",
                                                //  style: bold,
                                              ),
                                              subtitle: Text(
                                                "${isVolunteer() ? _userLastName : mosqueCode}",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                ),
                                              )),
                                          // ListTile(
                                          //  contentPadding: EdgeInsets.symmetric(
                                          //      horizontal: 12, vertical: 4),
                                          //  leading: Icon(Icons.my_location),
                                          //  title: Text("موقع المسجد"),
                                          //   subtitle: Text("USA"),
                                          // ),
                                          ListTile(
                                            onTap: () async {
                                              // final text  = await showTextInputDialog(context: context, textFields: [DialogTextField()]);
                                              final text =
                                              await showTextInputDialog(
                                                  context: context,
                                                  title:
                                                  ' البريد الالكتروني',
                                                  textFields: [
                                                    DialogTextField(
                                                        hintText: 'ادخل بريد الكتروني ',
                                                        validator: (value){
                                                          //   return !value!.contains('@') ? 'ادخل بريد الكتروني صحيح' : null;
                                                          if (value!.isEmpty || value.trim().isEmpty) {
                                                            return ("الرجاء قم بإدخال بريد إلكتروني");
                                                          }
                                                          // reg expression for email validation
                                                          if (!RegExp(
                                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                              .hasMatch(value)) {
                                                            return ("البريد الإلكتروني غير صحيح");//ASDFGHJKL123!
                                                          }
                                                          return null;

                                                        }
                                                    )
                                                  ],
                                                  okLabel: 'تأكيد',
                                                  cancelLabel: 'الغاء');
                                              // _userEmail.trim().isEmpty|| _userEmail!.isEmpty&&!regex2.hasMatch(_userEmail)?_displayemail=false:_displayemail=false;

                                              if (text != null)
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(auth.currentUser!.uid)
                                                    .update({
                                                  'email': text[0]
                                                }).then((value) {
                                                  setState(() {
                                                    auth.currentUser
                                                        ?.updateEmail(text[0]);
                                                    _userEmail = text[0];
                                                  });
                                                });
                                            },
                                            title: Text(
                                              "البريد الالكتروني",
                                              //  style: bold,
                                            ),
                                            subtitle: Text(
                                              "${_userEmail}",
                                              style: TextStyle(
                                                  fontFamily: 'Tajawal'),
                                            ),
                                            leading: Icon(Icons.mail),
                                            trailing: Icon(Icons.edit),
                                          ),
                                          ListTile(
                                            onTap: () async {
                                              //  final text  = await showTextInputDialog(context: context, textFields: [DialogTextField()]);
                                              final text =
                                              await showTextInputDialog(
                                                context: context,
                                                title: ' رقم الجوال',

                                                textFields: [DialogTextField(
                                                    hintText: ' أدخل رقم الجوال',
                                                    validator: (value){
                                                      // return !regex1.hasMatch(value!) ? 'ادخل رقم جوال صحيح  ' : null;
                                                      RegExp regex = RegExp(r'^((?:[0?5?]+)(?:\s?\d{8}))$');
                                                      if (value!.isEmpty || value.trim().isEmpty) {
                                                        return ("الرجاء إدخال رقم الجوال ");
                                                      }
                                                      if (!regex.hasMatch(value)) {
                                                        return ("ادخل رقم جوال صحيح");
                                                      }
                                                      if (value.length < 10) {
                                                        return ("ادخل رقم جوال صحيح");
                                                      }
                                                      return null;
                                                    }
                                                )],
                                                okLabel: 'تأكيد',
                                                cancelLabel: 'الغاء',
                                              );
                                              //    _userPhone.trim().isEmpty|| _userPhone!.isEmpty && _userPhone.length < 10 &&!regex1.hasMatch(_userPhone)?_displayphonnumber=false:_displayphonnumber=true;
                                              if (text != null)
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(auth.currentUser!.uid)
                                                    .update({
                                                  'phone_number': text[0]
                                                }).then((value) {
                                                  setState(() {
                                                    _userPhone = text[0];
                                                  });
                                                });
                                            },
                                            leading: Icon(
                                              Icons.phone,
                                            ),
                                            trailing: Icon(Icons.edit),
                                            title: Text(
                                              "رقم الجوال",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${_userPhone}",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          logout()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  } //QWEqwerty123@

  bool isVolunteer() => role == 'volunteer';
}
