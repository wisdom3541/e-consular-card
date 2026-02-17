// import 'package:e_consular_card/core/widget/common_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../domain/entities/payment.dart';

// class PaymentDetailPage extends StatelessWidget {
//   final Payment payment;

//   const PaymentDetailPage({
//     Key? key,
//     required this.payment,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       // appBar: CommonAppBar(
//       //   title: "Payment Details",
//       //   showBackButton: true,
//       //   trailing: IconButton(
//       //     icon: const Icon(Icons.download, color: Colors.white),
//       //     onPressed: () {
//       //       ScaffoldMessenger.of(context).showSnackBar(
//       //         const SnackBar(content: Text('Download receipt coming soon!')),
//       //       );
//       //     },
//       //   ),
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
            
//             _buildStatusBanner(),
//             SizedBox(height: 16.h),
//             _buildDetailsCard(),
//             SizedBox(height: 16.h),
//             _buildActionButtons(context),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusBanner() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: _getStatusGradient(),
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 16.h),
//           Icon(
//             _getStatusIcon(),
//             size: 72.sp,
//             color: Colors.white,
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             payment.statusText.toUpperCase(),
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//               //letterSpacing: 1.5,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             '\$${payment.amount.toStringAsFixed(2)}',
//             style: TextStyle(
//               fontSize: 30.sp,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailsCard() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Payment Information',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w700,
//               color: Colors.black87,
//             ),
//           ),
//           SizedBox(height: 20.h),
//           _buildDetailRow(label: 'Service Name:', value: payment.serviceName),
//           _buildDivider(),
//           _buildDetailRow(label: 'Service Code:', value: payment.serviceCode,
//               valueColor: AppColors.primary),
//           _buildDivider(),
//           if (payment.description != null) ...[
//             _buildDetailRow(label: 'Description:', value: payment.description!),
//             _buildDivider(),
//           ],
//           _buildDetailRow(label: 'Amount:', value: '\$${payment.amount.toStringAsFixed(2)}',
//               valueColor: AppColors.primary, valueFontWeight: FontWeight.w700),
//           _buildDivider(),
//           _buildDetailRow(label: 'Status:', value: payment.statusText,
//               valueWidget: _buildStatusBadge()),
//           _buildDivider(),
//           _buildDetailRow(
//             label: 'Payment Date:',
//             value: DateFormat('dd MMM yyyy, hh:mm a').format(payment.paymentDate),
//           ),
//           _buildDivider(),
//           _buildDetailRow(
//             label: 'Reference:',
//             value: payment.reference,
//             valueWidget: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   payment.reference,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade700,
//                     fontFamily: 'monospace',
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 GestureDetector(
//                   onTap: () {
//                     Clipboard.setData(
//                       ClipboardData(text: payment.reference),
//                     );
//                   },
//                   child: Icon(
//                     Icons.copy,
//                     size: 18.sp,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Download receipt coming soon!'),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.download),
//               label: const Text('Download Receipt'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 12.h),
//           SizedBox(
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Support feature coming soon!'),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.support_agent),
//               label: const Text('Contact Support'),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: AppColors.primary,
//                 side: const BorderSide(color: AppColors.primary),
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow({
//     required String label,
//     String? value,
//     Widget? valueWidget,
//     Color? valueColor,
//     FontWeight? valueFontWeight,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 12.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 130.w,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//           ),
//           Expanded(
//             child: valueWidget ??
//                 Text(
//                   value ?? '',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: valueFontWeight ?? FontWeight.w600,
//                     color: valueColor ?? Colors.black87,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(height: 1.h, thickness: 1, color: Colors.grey.shade200);
//   }

//   Widget _buildStatusBadge() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//       decoration: BoxDecoration(
//         color: payment.statusBackgroundColor,
//         borderRadius: BorderRadius.circular(6.r),
//       ),
//       child: Text(
//         payment.statusText,
//         style: TextStyle(
//           fontSize: 13.sp,
//           fontWeight: FontWeight.w700,
//           color: payment.statusColor,
//         ),
//       ),
//     );
//   }

//   List<Color> _getStatusGradient() {
//     switch (payment.status) {
//       case PaymentStatus.success:
//         return [AppColors.primary, AppColors.primaryLight];
//       case PaymentStatus.pending:
//         return [Colors.orange, Colors.orange.shade300];
//       case PaymentStatus.failed:
//         return [Colors.red, Colors.red.shade300];
//       case PaymentStatus.refunded:
//         return [Colors.grey, Colors.grey.shade400];
//     }
//   }

//   IconData _getStatusIcon() {
//     switch (payment.status) {
//       case PaymentStatus.success:
//         return Icons.check_circle;
//       case PaymentStatus.pending:
//         return Icons.schedule;
//       case PaymentStatus.failed:
//         return Icons.cancel;
//       case PaymentStatus.refunded:
//         return Icons.replay;
//     }
//   }
// }