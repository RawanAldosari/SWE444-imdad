import 'dart:convert';



import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';
import 'package:swe444/Widgets/show_snackbar.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({
    required this.message,
    required this.success,
  });
}

class StripeServices {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeServices.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret = 'sk_test_51JoVBWLZ1llzUX5WiTxtMR8HF3hVaMSAwO2LjcAzh9qQJT8MmlA4saZS466oRLHvTIgrpojv2OzIRCmjVgvuKwkh00FRoPO3Ci';
 
  
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeServices.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
        'pk_test_51JoVBWLZ1llzUX5WqL4VUDxYKslZC9uSpdKK4TJAqGrNJE4dMmd1tTYc7gS8yrPDbiqlybF0d0yxbCrBNFEXFUai00cLUT3NG3',
        androidPayMode: 'test',
        merchantId: 'test'));
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency, String description) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'description': description,
      };

      var response =
      await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error Happened');
      throw error;
    }
  }

  static Future<StripeTransactionResponse> payNowHandler(
    {required String amount, required String currency, required String description}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
      await StripeServices.createPaymentIntent(amount, currency, description);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));

      if (response.status == 'succeeded') {
        // final GlobalKey<ScaffoldMessengerState> snackbarKey =
        // GlobalKey<ScaffoldMessengerState>();

        // final SnackBar snackBar = SnackBar(content: Text("عملية الدفع تمت بنجاح"));
        // snackbarKey.currentState?.showSnackBar(snackBar);
        // BuildContext context;
        // String? errorMessage='عملية الدفع تمت بنجاح';
        // Snackbar?  snackbar = Snackbar(context, errorMessage, "pass");
        // snackbar.showToast();
     //   Get.snackbar('Hi', 'i am a modern snackbar');
     //    StripePayment.confirmPaymentIntent(
     //      PaymentIntent(
     //        clientSecret: secret,
     //
     //      ),
     //    ).then((paymentIntent) {
     //      _scaffoldKey.currentState
     //          .showSnackBar(SnackBar(content: Text('Received ${paymentIntent.paymentIntentId}')));
     //
     //    });


        return StripeTransactionResponse(
            message: 'تمت عملية الدفع بنجاح', success: true);

      } else {
        return StripeTransactionResponse(
            message: 'لم تتم عملية الدفع بنجاح', success: false);
      }
    }

    // catch (error) {
    //   return StripeTransactionResponse(
    //       message: 'Transaction failed in the catch block', success: false);
    // }

    on PlatformException catch (error) {
      return StripeServices.getErrorAndAnalyze(error);
    }
  }

  static getErrorAndAnalyze(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction canceled';
    }
    return StripeTransactionResponse(message: message, success: false);
  }
}