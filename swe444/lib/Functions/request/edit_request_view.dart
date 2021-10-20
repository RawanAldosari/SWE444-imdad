import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/request/post_request_view.dart';
import 'edit_request_form.dart';
import '../home_screen/mm_home_view.dart';

class EditRequest extends StatefulWidget {
  EditRequest.ensureInitialized();
  const EditRequest({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditRequestState();
  }
}

class _EditRequestState extends State<EditRequest> {
  final List<Widget> _children = [
    mmHome(),
    PostRequest(),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    bool portrait = true;

    if (deviceOrientation == Orientation.landscape) portrait = false;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: const Color(0xffededed),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                    ),
                    const Text(
                      'نموذج تعديل الطلب',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff334856),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: portrait == true ? 15.h : 20.h),
                    Container(
                      // height: portrait == true ? 580.h : 1100.h,
                      width: portrait == true ? 330.w : 280.w,
                      padding:
                      const EdgeInsets.only(left: 12, right: 12, top: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                      ),
                      child: EditRequestForm(),
                    ),
                    SizedBox(height: portrait == true ? 120.h : 230.h),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
