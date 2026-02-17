import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import '../../../../core/theme/app_colors.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String checkoutUrl;
  final String reference;
  final double amount;

  const PaymentWebViewPage({
    Key? key,
    required this.checkoutUrl,
    required this.reference,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
void initState() {
  super.initState();

  if (Platform.isAndroid) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  }

  _initializeWebView();
}


  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)

      // 🔥 Force mobile user agent
      ..setUserAgent("Mozilla/5.0 (Linux; Android 13; Mobile) "
          "AppleWebKit/537.36 (KHTML, like Gecko) "
          "Chrome/120.0.0.0 Mobile Safari/537.36")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });

            // Check if payment was completed
            _checkPaymentCompletion(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Error loading payment page: ${error.description}'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }
void _checkPaymentCompletion(String url) {
  if (url.contains('/globalpay/callback')) {
    final uri = Uri.parse(url);
    final reference = uri.queryParameters['reference'];

    Navigator.pop(context, {
      'status': 'verify',
      'reference': reference,
    });
  }
}

  // void _checkPaymentCompletion(String url) {
  //   // Check if URL indicates payment completion
  //   // This depends on GlobalPay's redirect URLs
  //   if (url.contains('success') ||
  //       url.contains('completed') ||
  //       url.contains('payment-successful')) {
  //     _handlePaymentComplete();
  //   } else if (url.contains('failed') ||
  //       url.contains('cancelled') ||
  //       url.contains('error')) {
  //     _handlePaymentFailed();
  //   }
  // }

  void _handlePaymentComplete() {
    // Return success to previous page
    Navigator.pop(context, {
      'status': 'success',
      'reference': widget.reference,
    });
  }

  void _handlePaymentFailed() {
    // Return failure to previous page
    Navigator.pop(context, {
      'status': 'failed',
      'reference': widget.reference,
    });
  }

  void _handleManualClose() {
    // Show confirmation dialog before closing
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Payment?'),
        content: const Text(
          'Are you sure you want to cancel this payment? Your transaction will not be completed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Payment'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, {
                'status': 'cancelled',
                'reference': widget.reference,
              }); // Close webview
            },
            child: const Text(
              'Cancel Payment',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _handleManualClose,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading payment page...',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Amount: \$${widget.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
