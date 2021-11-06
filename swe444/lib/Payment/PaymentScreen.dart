import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'package:swe444/Functions/home_screen/v_feed.dart';
import 'package:swe444/Functions/home_screen/moneyVFeed.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
//import 'package:stripe/StripeGateway.dart';

import 'StripeGateway.dart';

class PaymentScreen extends StatefulWidget {
  static int? vDonatedAmount = 0;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  int isVDonatedPaymentScreen = 0;

  //int? vDonatedAmount=int.parse(_controller.text);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeServices.init();
  }

  // void payNow() async {
  //   //the amount must be transformed to cents
  //   var  response =
  //   await StripeServices.payNowHandler(amount: (double.parse(_controller.text) * 100.roundToDouble()).toString(), currency: 'USD');
  //
  //   //showSnackBar();
  //
  //   // Snackbar?  snackbar = Snackbar(context, response.message, "pass");
  //   // snackbar.showToast();
  //   print(response.message);
  //
  // }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    final donated = double.parse(text);
    final check = mv_feed.wholeAmount - donated;

    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code

    if (text == null || text.isEmpty || text.trim().isEmpty)
      return "الرجاء إدخال قيمة التبرع المرغوبة";
    else {
      if (donated > 50000) return "أقصى قيمة للتبرع= 50000";
      if (donated < 10) return "أدنى قيمة للتبرع = 10";
      if (!donated.isNaN) return "الرجاء إدخال قيمة عددية";
      if (check == 0) return "الحالة مكتملة ، شكراً لتعاونك";

      if (donated > mv_feed.wholeAmount)
        return " قيمة التبرع أكبر من المبلغ المطلوب ، المبلغ المتبقي للتبرع هو $check";
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Row(
            children: [
              Text(
                "عملية التبرع بالمال",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff334856),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      textDirection: TextDirection.rtl,
                      size: 30,
                      color: Color(0xff334856),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      //   Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
        //automaticallyImplyLeading: false,
        backgroundColor: const Color(0xdeedd03c),
        bottomOpacity: 30,
        // elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 0,
          left: 50,
          right: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: 280,
                  width: 280,
                  child: Image.asset('images/money.png')),
              Form(
                key: _formKey,
                child: Container(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      controller: _controller,
                      decoration: InputDecoration(
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,

                        //  textAlign: TextAlign.end,
                        hintText: 'ريال سعودي ',
                        //    hintTextDirection: TextAlign.left,
                        labelText: 'أدخل المبلغ المراد التبرع به',
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xdeedd03c),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 5,
                              color: Color(0xdeedd03c),
                            )),
                      ),
                      textAlign: TextAlign.left,
                      inputFormatters: [new WhitelistingTextInputFormatter(RegExp("[0-9]")),],
                      onSaved: (value) {
                        _controller.text = value!;
                      },
                      validator: (value) {
                       // String text = _controller.text;
                        value =_controller.text;

                        if (value == null || value.isEmpty || value.trim().isEmpty)
                          return "الرجاء إدخال قيمة التبرع المرغوبة";
                        else
                        {
                          if (value != null) {
                            int donated = int.parse(value);
                            int check = mv_feed.wholeAmount -
                                mv_feed.wholeDonated;
                            if (donated > 50000)
                              return "أقصى قيمة للتبرع= 50000";
                            if (donated < 10) return "أدنى قيمة للتبرع = 10";

                            if (check == 0)
                              return "الحالة مكتملة ، شكراً لتعاونك";

                            if (donated > mv_feed.wholeAmount)
                              return " قيمة التبرع أكبر من المبلغ المطلوب ، المبلغ المتبقي $check";
                          }}

                      //  return "الرجاء إدخال قيمة عددية";
                        // return null if the text is valid
                        return null;
                      },
                    ),

                    //onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //     dollarToSR=(double.parse(_controller.text) * 100)*3.75050163;
                    PaymentScreen.vDonatedAmount =
                        int.parse(_controller.text);
                   // int? inGate = (PaymentScreen.vDonatedAmount!* 0.27 ).toInt();
                     double? inGate = PaymentScreen.vDonatedAmount!* 0.27;

                    String? mmEmailToGate = mv_feed.mmEmailDonated;
                    String? mmNameToGate = mv_feed.mmNameDonated;
                    //   String description = '$mmEmailToGate  لمدير المسجد صاحب البريد الإلكتروني  $mmNameToGate ريال سعودي لصالح المسجد $inGate التبرع بالمبلغ ';
                    List<String> list = [
                      "التبرع بالمبلغ $inGate  \$ ",
                      " لصالح مسجد $mmNameToGate ",
                      " $mmEmailToGate  لمدير المسجد صاحب البريد الإلكتروني "
                    ];
                    var stringList = list.join("");
                    String description = stringList;

                    //convert from USD to saudi Riyal
                    int amount1=((int.parse(_controller.text))*0.27* 100).toInt();
                    String amount = amount1.toString();

                    var response = await StripeServices.payNowHandler(
                        amount: amount,
                        currency: 'USD',
                        description: description);
                    print(response.message);

                    showAlertDialog(context, response);
                    feedbackResponseDonation(response);
                  } else {

                    String errorMessage= 'الرجاء التأكد من القيمة العددية المدخلة';
                    var snackbar2 = Snackbar(context, errorMessage, "fail");
                    snackbar2.showToast();
                  }
                },
                child: Text(
                  'ادفع الآن',
                  style: TextStyle(fontFamily: "Tajawal", color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(85.w, 40.h),
                  primary: const Color(0xdeedd03c),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// get donated{
//   if(feedbackResponseDonation)
//   return int.parse(_controller.text) * 100;
//   else return 0;
// }

  showAlertDialog(BuildContext context, var response) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "موافق",
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal", color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xdeedd03c))),
      onPressed: () {
        // VolunteerFeed();
//PaymentScreen();
        Navigator.of(context).pop(context);

        if ((response.message) == 'تمت عملية الدفع بنجاح') {
          Navigator.of(context).pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h),
      title: Text(
        "تأكيد عملية الدفع ",
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Tajawal",
          color: const Color(0xdeedd03c),
        ),
      ),
      content: Text(
        feedbackResponse(response)!,
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal"),
      ),
      actions: [
        okButton,
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

  String? feedbackResponse(var response) {
    //var response
    if ((response.message) == 'تمت عملية الدفع بنجاح') {
      // isVDonatedPaymentScreen=1;

      return "تمت عملية التبرع بنجاح \n  شاكرين لك مساهمتك";
    } else if ((response.message) == 'Transaction canceled' ||
        (response.message) == 'Something went wrong' ||
        (response.message) == "لم تتم عملية التبرع بنجاح") {
      PaymentScreen.vDonatedAmount = 0;
      //  isVDonatedPaymentScreen=0;
      return "لم تتم عملية التبرع بنجاح";
    } else {
      //  isVDonatedPaymentScreen=0;
      PaymentScreen.vDonatedAmount = 0;
      return "لم تتم عملية التبرع بنجاح";
    }
  }

  int donated() {
    if (isVDonatedPaymentScreen == 1) {
      isVDonatedPaymentScreen = 0;
      return int.parse(_controller.text) * 100;
    } else
      return 0;
  }

  int? feedbackResponseDonation(var response) {
    //var response
    if ((response.message) == 'تمت عملية الدفع بنجاح') {
      return 1;
    } else if ((response.message) == 'Transaction canceled' ||
        (response.message) == 'Something went wrong' ||
        (response.message) == "لم تتم عملية التبرع بنجاح") {
      return 0;
    } else
      return 0;
  }
}