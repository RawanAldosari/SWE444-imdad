import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class PostRequest extends StatefulWidget {
  const PostRequest({Key? key}) : super(key: key);
  @override
  _PostRequestState createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 1;
  String? type;
  String? postedBy;
  int amount = 0;
  String? description;
  String? title;
  final List<String> items = ['Funds'];

  Widget _buildType(bool orientation) {
    double h1 = 0, h2=0, b1=0;
    if (orientation == true) {
      h1 = 10;
      b1=3;
      h2=18;
    } else {
      h1 = 60;
      h2= 70;
      b1= 5;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 52.h : 110.h,
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: orientation == true ? 190.w : 180.w,
                    height: orientation == true ? 32.h : 70.h,
                    padding: EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: orientation == true ? 190.w : 180.w,
                    height: orientation == true ? 52.h : 110.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: h2, vertical: b1),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration.collapsed(
                            hintText: "",
                          ),
                          value: type,
                          items: items.map<DropdownMenuItem<String>>(
                              (dropdownMenuItem) {
                            return DropdownMenuItem(
                              value: dropdownMenuItem,
                              child: Text(dropdownMenuItem),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => this.type = value),
                          validator: (value) =>
                              value == null ? 'Please choose a type' : null,
                          hint: Text("Select item"),
                          icon: Icon(Icons.arrow_drop_down_circle),
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: orientation == true ? 40.w : 30.w),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              ),
              Text(
                "نوع الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff334856),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle(bool orientation) {
    double h1 = 0, l1=0, h2=0 ;
    double top1 = 0;

    if (orientation == true) {
      h1 = 10;
      h2=0;
      l1 =10.0;
      top1 = 9;
    } else {
      h1 = 60;
      h2= 40;
      l1=20.0;
      top1 = 9;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 90.h : 190.h,
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: orientation == true ? 187.w : 180.w,
                    height: orientation == true ? 32.h : 70.h,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: h1, right: h1),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: orientation == true ? 167.w : 162.w,
                        height: orientation == true ? 75.h : 163.h,
                        margin: EdgeInsets.only(left: l1, top: top1),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: h2, vertical: 10.0),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Title is required";
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 8, 0, 0),
                                hintStyle: TextStyle(fontSize: 16)),
                            onChanged: (_val) {
                              title = _val;
                            }, // onchanged
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: orientation == true ? 40.w : 30.w),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
              ),
              Text(
                "عنوان الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff334856),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetails(bool orientation) {
    double h1 = 0, t1 = 0, b1 = 0;
    double l1 = 0;
    if (orientation == true) {
      l1 = 0;
      b1 = 16;
      t1 = 21.5;
      h1 = 10;
    } else {
      b1 = 18;
      t1 = 20;
      h1 = 60;
      l1 = 50;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 118.h : 200.h,
      child: Column(
        children: <Widget>[
          Container(
            width: orientation == true ? 300.w : 300.w,
            height: orientation == true ? 18.h : 39.h,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: <Widget>[
                      Text(
                        "تفاصيل الطلب",
                        style: TextStyle(
                          color: const Color(0xff334856),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Tajawal',
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(width: orientation == true ? 11.w : 29.w),
                    ],
                  )
                ]),
          ),
          Container(
            width: orientation == true ? 300.w : 300.w,
            height: orientation == true ? 100.h : 159.h,
            child: Row(
              children: [
                Stack(children: [
                  Column(
                    children: [
                      Stack(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 23),
                          width: orientation == true ? 140.w : 150.w,
                          height: orientation == true ? 30.h : 70.h,
                          padding:
                              EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xffffffff),
                              border: Border.all(
                                  width: 0.5, color: const Color(0xffdfdfdf)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: orientation == true ? 130.w : 100.w,
                              height: orientation == true ? 55.h : 115.h,
                              margin: EdgeInsets.only(left: l1, top: t1),
                              padding: EdgeInsets.fromLTRB(11, 0, 0, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "required";
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(30, 0, 0, b1),
                                    hintStyle: TextStyle(fontSize: 16)),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (_val) {
                                  var _val2 = int.parse(_val), amount = _val2;
                                }, // onchanged
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(18, 28, 0, 0),
                          child: Text(
                            'ريال',
                            style: TextStyle(
                              fontFamily: 'Academy Engraved LET',
                              fontSize: 12,
                              color: const Color(0xffd2d2d2),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ]),
                SizedBox(width: orientation == true ? 10.w : 0.w),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 17, 0, 15),
                    ),
                    Text(
                      "المبلغ",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xff334856),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(bool orientation) {
    double h1 = 0, l1;
    if (orientation == true) {
      h1 = 10;
      l1 = 0;
    } else {
      l1 = 20;
      h1 = 60;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 140.h : 285.h,
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: <Widget>[
                    Text(
                      "وصف إضافي",
                      style: TextStyle(
                        color: const Color(0xff334856),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(width: orientation == true ? 11.w : 29.w),
                  ],
                )
              ]),
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20, left: l1),
                        width: orientation == true ? 300.w : 250.w,
                        height: orientation == true ? 100.h : 200.h,
                        padding:
                            EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Color(0xffffffff),
                            border: Border.all(
                                width: 0.5, color: const Color(0xffdfdfdf)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 16, 0, 16),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(150)
                              ],
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              onChanged: (_val) {
                                description = _val;
                              }, // onchanged
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

// https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("إلغاء"),
      onPressed: () {},
    );
    Widget confirmButton = ElevatedButton(
      child: Text("تأكيد"),
      onPressed: () {
        add();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("إضافة"),
      content: Text("هل أنت متأكد من رغبتك في إضافة الطلب؟"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    bool portrait = true;

    if (deviceOrientation == Orientation.landscape) portrait = false;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        title: Text(
          "إضافة طلب جديد",
          style: TextStyle(
            color: const Color(0xff334856),
            fontWeight: FontWeight.w700,
            fontFamily: 'Tajawal',
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xdeedd03c),
        bottomOpacity: 30,
        // elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              Text(
                'نموذج إضافة طلب جديد',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff334856),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: portrait == true ? 15.h : 20.h),
              Container(
                height: portrait == true ? 520.h : 980.h,
                width: portrait == true ? 330.w : 280.w,
                padding:
                    const EdgeInsets.only(left: 12, right: 12, top: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffffffff),
                  border:
                      Border.all(width: 0.5, color: const Color(0xffdfdfdf)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildType(portrait),
                      _buildTitle(portrait),
                      _buildDetails(portrait),
                      _buildDescription(portrait),
                      SizedBox(height: portrait == true ? 30.h : 15.h),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showAlertDialog(context);
                          }
                        },
                        child: Text(
                          "إضافة",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "lato",
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120.w, 35.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          primary: const Color(0xdeedd03c),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), topLeft: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                color: Color(0xffededed), spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: BottomNavigationBar(
              backgroundColor: Colors.white,
              iconSize: 40,
              selectedItemColor: const Color(0xdeedd03c),
              unselectedItemColor: const Color(0xff334856),
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text("الصفحة الرئيسية"),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.add),
                  title: new Text("إضافة طلب"),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.account_circle),
                  title: new Text("الصفحة الشخصية"),
                ),
              ]),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance.collection('Requests');

    var data = {
      'title': title,
      'type': type,
      'posted_by': postedBy,
      'description': description,
      'amount': amount,
    };

    ref.add(data);

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => PostRequest(),
      ),
    )
        .then((value) {
      print("Calling Set State !");
      setState(() {});
    });

    _formKey.currentState?.reset();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
