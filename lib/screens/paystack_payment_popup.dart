import 'dart:convert';
import 'package:e_consular_card/core/verify_payment_api.dart';
import 'package:e_consular_card/providers/loggedIn/cart_provider.dart';
import 'package:e_consular_card/providers/login_screen_provider.dart';
import 'package:e_consular_card/screens/createAccountWithNIN.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaystackPaymentPopup extends StatefulWidget {
  final int amount ;
  const PaystackPaymentPopup({Key? key,  required this.amount}) : super(key: key);

  @override
  State<PaystackPaymentPopup> createState() => _PaystackPaymentPopup();
}

class _PaystackPaymentPopup extends State<PaystackPaymentPopup> {

 
  
  late final WebViewController _controller;
  bool showWebView = false;
  String checkoutUrl = "";
  final String paystackPublicKey =
      "pk_test_b90f24c6564e82ff5aaf4ca6d692f4b70ca7edf4";
  final String testEmail = "testdash@gmail.com";
  bool isLoading = false;
  late String reference;
  final String paystackSecretKey =
      "sk_test_3e0e21fd3894518acde834a3ca5b8e71a2cd6d89";

  Future<void> initializeTransaction() async {

    int amountInKobo = widget.amount * 100;
    setState(() {
      isLoading = true;
    });
    String token = Provider.of<LoginScreenProvider>(context, listen: false)
        .userLoggedInToken;

    final url = Uri.parse('https://api.paystack.co/transaction/initialize');
    final headers = {
      'Authorization': 'Bearer $paystackSecretKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'email': testEmail,
      'amount': amountInKobo,
      'callback_url': 'https://myapp.com/paystack/callback',
      'cancel_url': 'https://yourapp.com/cancel',
      'metadata': {
      'cancel_url': 'https://yourapp.com/cancel',
      }
    });

    final response = await http.post(url, headers: headers, body: body);

    setState(() {
      isLoading = false;
    });

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200 && responseData['status']) {
      print("datttaaa ::  $responseData");
      setState(() {
        checkoutUrl = responseData['data']['authorization_url'];
        String ref = responseData['data']['reference'];
        reference = ref;

        print(reference);
        showWebView = true;
      });

      // var response = await VerifyPaymentApi().verifyOrderPayment(token, reference, order_id);
      //       print(response!.success);
      //       print(response.message);
    } else {
      debugPrint("Error: ${response.body}");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Failed"),
          content: Text("Could not start transaction"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      print("ready");
      initializeTransaction();
    });
  }

  WebViewController _buildWebViewController(String url) {
    var cartRes =
        Provider.of<CartProvider>(context, listen: false).cartResponse;
    String order_id = cartRes.orderId!;
    String token = Provider.of<LoginScreenProvider>(context).userLoggedInToken;

    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains("callback")) {
              var response = await VerifyPaymentApi()
                  .verifyOrderPayment(token, reference, order_id);
              Navigator.of(context).pop({
                "status": response?.success == true ? "success" : "error",
                "message": response?.message ?? "Verification failed",
                "data": response,
              });
              return NavigationDecision.prevent;
            }
            if (request.url.contains("cancel")) {
              Navigator.of(context).pop({
              "status": "cancelled",
              "message": "User cancelled the payment"
            });
            return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : showWebView
              ? WebViewWidget(controller: _buildWebViewController(checkoutUrl))
              : const Center(
                  child: Text("Please wait. Payment gateway Loading"),
                ),
    );
  }
}
