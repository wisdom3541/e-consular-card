// import 'package:e_consular_card/core/widget/common_app_bar.dart';
// import 'package:e_consular_card/features/auth/domain/entities/card_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../providers/card_request_provider.dart';

// class CardRequestPage extends StatelessWidget {
//   const CardRequestPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CardRequestProvider(),
//       child: const _CardRequestPageContent(),
//     );
//   }
// }

// class _CardRequestPageContent extends StatelessWidget {
//   const _CardRequestPageContent();

//   Future<void> _handleSubmit(BuildContext context) async {
//     final provider = context.read<CardRequestProvider>();

//     // if (provider.selectedServices.isEmpty) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(
//     //       content: Text('Please select at least one service'),
//     //       backgroundColor: Colors.red,
//     //     ),
//     //   );
//     //   return;
//     // }

//     final success = await provider.submitCardRequest();

//     if (!context.mounted) return;

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Card request submitted successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
      
//       // Navigate back to dashboard
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(provider.errorMessage ?? 'Request failed'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CommonAppBar(
//         title: "Request Card",
//         showBackButton: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               SizedBox(height: 20.h),
//               _buildIncludedServices(),
//               SizedBox(height: 20.h),
//               _buildDeliveryOption(),
//               SizedBox(height: 20.h),
//               _buildPaymentSummary(),
//               SizedBox(height: 20.h),
//               _buildSubmitButton(context),
//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'eConsular Card Request',
//               style: TextStyle(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade50,
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Consumer<CardRequestProvider>(
//                 builder: (context, provider, _) {
//                   return Text(
//                     'Validity: ${provider.validityPeriod}',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Colors.green,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'A secure & verifiable identity',
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildIncludedServices() {
//     return Consumer<CardRequestProvider>(
//       builder: (context, provider, _) {
//         return Card(
//           color: AppColors.backgroundLight,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Included Services',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 _buildServiceHeader(),
//                 SizedBox(height: 12.h),
//                 ...provider.availableServices.map((service) {
//                   return _buildServiceRow(service, provider);
//                 }).toList(),
//                 Divider(height: 24.h, thickness: 1),
//                 _buildSubtotalRow(provider),
//                 SizedBox(height: 8.h),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       // TODO: Show breakdown details
//                     },
//                     child: Text(
//                       'Toggle Breakdown',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildServiceHeader() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Text(
//             'SERVICE',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 4,
//           child: Text(
//             'DESCRIPTION',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             'AMOUNT (USD)',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceRow(CardService service, CardRequestProvider provider) {
//     final isSelected = provider.selectedServices.contains(service);

//     return Padding(
//       padding: EdgeInsets.only(bottom: 12.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               service.name,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Text(
//               service.description,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               '\$${service.amount.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubtotalRow(CardRequestProvider provider) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Service Subtotal',
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         Text(
//           '\$${provider.serviceSubtotal.toStringAsFixed(2)}',
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w700,
//             color: AppColors.primary,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDeliveryOption() {
//     return Consumer<CardRequestProvider>(
//       builder: (context, provider, _) {
//         return Card(
//           color: AppColors.backgroundLight,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Delivery Option',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 CheckboxListTile(
//                   value: provider.enableDelivery,
//                   onChanged: (value) {
//                     provider.toggleDelivery(value ?? false);
//                   },
//                   title: Text(
//                     'Enable Delivery (optional)',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   activeColor: AppColors.primary,
//                   contentPadding: EdgeInsets.zero,
//                   controlAffinity: ListTileControlAffinity.leading,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentSummary() {
//     return Consumer<CardRequestProvider>(
//       builder: (context, provider, _) {
//         return Card(
//           color: AppColors.backgroundLight,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Payment Summary',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 _buildSummaryRow(
//                   'Service Subtotal',
//                   '\$${provider.serviceSubtotal.toStringAsFixed(2)}',
//                 ),
//                 SizedBox(height: 8.h),
//                 _buildSummaryRow(
//                   'Delivery Fee',
//                   '\$${provider.deliveryFee.toStringAsFixed(2)}',
//                 ),
//                 Divider(height: 24.h, thickness: 1),
//                 _buildSummaryRow(
//                   'Total',
//                   '\$${provider.total.toStringAsFixed(2)}',
//                   isBold: true,
//                   isTotal: true,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSummaryRow(String label, String amount,
//       {bool isBold = false, bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
//             color: isTotal ? Colors.black : Colors.grey.shade700,
//           ),
//         ),
//         Text(
//           amount,
//           style: TextStyle(
//             fontSize: isBold ? 18.sp : 14.sp,
//             fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
//             color: isTotal ? Colors.black : Colors.grey.shade700,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubmitButton(BuildContext context) {
//     return Consumer<CardRequestProvider>(
//       builder: (context, provider, _) {
//         return SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: provider.isLoading
//                 ? null
//                 : () => _handleSubmit(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primary,
//               disabledBackgroundColor: Colors.grey.shade300,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 8.h),
//             ),
//             child: provider.isLoading
//                 ? const CircularProgressIndicator(color: Colors.white)
//                 : Column(
//                     children: [
//                       Text(
//                         'Request Card Now',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         'Pay securely with Globalpay',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
import 'package:e_consular_card/features/dashboard/data/models/card_request_response.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/card_request_provider.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:e_consular_card/features/payments/presentation/providers/payment_processing_provider.dart';
import 'package:e_consular_card/features/payments/presentation/screen/payment_webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
class CardRequestPage extends StatefulWidget {
  const CardRequestPage({Key? key}) : super(key: key);

  @override
  State<CardRequestPage> createState() => _CardRequestPageState();
}

class _CardRequestPageState extends State<CardRequestPage> {
  @override
  void initState() {
    super.initState();
    // Reset any previous state
       WidgetsBinding.instance.addPostFrameCallback((_) {
       context.read<CardRequestProvider>().reset();
     });
    // Future.microtask(() {
    //   context.read<CardRequestProvider>().reset();
    // });
  }

  Future<void> _handleSubmitRequest() async {
    final provider = context.read<CardRequestProvider>();

    showLoadingDialog(context);

    final success = await provider.submitCardRequest();

    if (!mounted) return;
    hideLoadingDialog(context);

    if (success && provider.currentRequest != null) {
      // Show success and payment summary
      _showPaymentSummary(provider.currentRequest!);
    } else {
      showErrorSnackbar(
        context,
        provider.errorMessage ?? 'Failed to submit card request',
      );
    }
  }



void _showPaymentSummary(CardRequestData request) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 28.sp),
          SizedBox(width: 12.w),
          const Text('Request Initiated'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction ID:',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            request.transactionId,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Services:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          ...request.services.map((service) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      service.name,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    '\$${service.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
          if (request.isDeliveryIncluded) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery', style: TextStyle(fontSize: 13.sp)),
                Text(
                  '\$25.00',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          Divider(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '\$${request.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Go back to dashboard
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            _handleProceedToPayment(request);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: const Text('Proceed to Payment',style: TextStyle(color: Colors.white),),
        ),
      ],
    ),
  );
}

Future<void> _handleProceedToPayment(CardRequestData request) async {
  final paymentProvider = context.read<PaymentProcessingProvider>();

  // Show loading
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  // Initialize payment
  final paymentData = await paymentProvider.initializePayment();

  if (!mounted) return;
  Navigator.pop(context); // Close loading

  if (paymentData != null) {
    // Open payment webview
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWebViewPage(
          checkoutUrl: paymentData.checkoutUrl,
          reference: paymentData.reference,
          amount: paymentData.amount,
        ),
      ),
    );

    if (!mounted) return;

    // Handle payment result
    if (result == null) return;

if (result['status'] == 'verify') {
  await _verifyPayment(result['reference']);
} else if (result['status'] == 'cancelled') {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Payment cancelled'),
      backgroundColor: Colors.orange,
    ),
  );
}

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          paymentProvider.errorMessage ?? 'Failed to initialize payment',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> _verifyPayment(String reference) async {
  final paymentProvider = context.read<PaymentProcessingProvider>();

  // Show loading
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  // Verify payment
  final isVerified = await paymentProvider.verifyPayment(reference);

  if (!mounted) return;
  Navigator.pop(context); // Close loading

  if (isVerified) {
    // Payment successful
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32.sp),
            SizedBox(width: 12.w),
            const Text('Payment Successful!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your payment has been confirmed. Your card request is being processed.',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            if (paymentProvider.verificationResult != null)
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reference:',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        Text(
                          reference,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount:',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        Text(
                          '\$${paymentProvider.verificationResult!.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to dashboard
              
              // Refresh dashboard
              context.read<DashboardProvider>().loadDashboardData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  } else {
    // Payment verification failed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          paymentProvider.errorMessage ?? 'Payment verification failed',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CardRequestProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CommonAppBar(title: "Request Card"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'e-Consular Card Request',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Your card request includes the following services:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Services List
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildServiceItem(
                      'e-Consular Card',
                      'Access to consular services',
                      '\$100.00',
                    ),
                    Divider(height: 24.h),
                    _buildServiceItem(
                      'NIN Verification',
                      'National Identity verification',
                      '\$25.00',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Delivery Option
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: provider.includeDelivery,
                      onChanged: (value) {
                        provider.setIncludeDelivery(value ?? false);
                      },
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Include Delivery',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Card will be delivered to your address (+\$25.00)',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Payment Summary
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$125.00',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    if (provider.includeDelivery) ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '\$25.00',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                    Divider(color: Colors.white, height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$${provider.includeDelivery ? "150.00" : "125.00"}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text(
                    'Request Card Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Note
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment, color: Colors.orange, size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Payment will be processed through Globalpay secure gateway',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(String name, String description, String price) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.card_membership,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}