import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../View/chat_view.dart';

class MyPaymentHelper extends GetxController{

  Map<String,dynamic>? paymentItentData;

  createPayment(String amount,String currency) async{
    try {
      Map<String,dynamic> body = {
        'amount':calculate(amount),
        'currency':currency,
        'payment_method_types[]':'card'
      };
      Map<String,String> headers = {
        'Authorization': "Bearer sk_test_51GQ8hTDVXOXIy9Uxm4xNL9B8TNe81JqkYxwM7is0MerO0x6UOaJJtqyCI9TBTG2CaTj5hIEx7TJpgc19OIj0YXPY00jMNVWtm8",
        "content-Type": "application/x-www-form-urlencoded"
      };
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),body: body,headers: headers);
      return jsonDecode(response.body);
    }
    catch(err){
      print("err : user : ${err.toString()}");
    }
  }

  Future<void> makePayment({required BuildContext context, required String amount, required String currency, required String uberName, required String uberId}) async {
    try {
      paymentItentData = await createPayment(amount, currency);
      if (paymentItentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: 'propects',
                customerId: paymentItentData!["customer"],
                paymentIntentClientSecret: paymentItentData!["client_secret"],
                customerEphemeralKeySecret: paymentItentData!['ephemeral']
            )
        );
        displaySheet(context, uberName, uberId);
      }
    }
    catch (e, s) {
      print('exception $e$s');
    }
  }

  displaySheet(BuildContext context, String uberName, String uberId) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar("Payment", 'Payement Succesful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatView(uberId: uberId, uberName: uberName, isUber: false,),
        ),
      );

    } on Exception catch(e){
      if( e is StripeException){
        print("erreur venant de stripe : ${e.error.localizedMessage}");
      }
      else
      {
        print(e);
      }
    }
    catch (e){
      print(e);
    }
  }

  calculate(String amount){
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

}