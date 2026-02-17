// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../domain/entities/payment.dart';

// class PaymentTable extends StatelessWidget {
//   final List<Payment> payments;
//   final Function(Payment) onPaymentTap;

//   const PaymentTable({
//     Key? key,
//     required this.payments,
//     required this.onPaymentTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           width: 900.w, // Fixed width for table
//           child: Column(
//             children: [
//               _buildTableHeader(),
//               ...payments.map((payment) => _buildTableRow(payment, context)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTableHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: AppColors.greyLight,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12.r),
//           topRight: Radius.circular(12.r),
//         ),
//       ),
//       child: Row(
//         children: [
//           SizedBox(width: 40.w), // Checkbox space
//           SizedBox(
//             width: 100.w,
//             child: _buildHeaderText('SERVICE'),
//           ),
//           SizedBox(
//             width: 120.w,
//             child: _buildHeaderText('AMOUNT'),
//           ),
//           SizedBox(
//             width: 120.w,
//             child: _buildHeaderText('STATUS'),
//           ),
//           SizedBox(
//             width: 200.w,
//             child: _buildHeaderText('PAYMENT DATE'),
//           ),
//           SizedBox(
//             width: 180.w,
//             child: _buildHeaderText('REFERENCE'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderText(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w700,
//         color: Colors.grey.shade600,
//         letterSpacing: 0.5,
//       ),
//     );
//   }

//   Widget _buildTableRow(Payment payment, BuildContext context) {
//     return GestureDetector(
//       onTap: () => onPaymentTap(payment),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Colors.grey.shade200),
//           ),
//         ),
//         child: Row(
//           children: [
//             // Checkbox
//             Container(
//               width: 20.w,
//               height: 20.w,
//               margin: EdgeInsets.only(right: 20.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(4.r),
//               ),
//             ),

//             // Service Code
//             SizedBox(
//               width: 100.w,
//               child: Text(
//                 payment.serviceCode,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),

//             // Amount
//             SizedBox(
//               width: 120.w,
//               child: Text(
//                 '\$${payment.amount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),

//             // Status
//             SizedBox(
//               width: 120.w,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: payment.statusBackgroundColor,
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   payment.statusText,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: payment.statusColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),

//             // Payment Date
//             SizedBox(
//               width: 200.w,
//               child: Text(
//                 DateFormat('dd MMM yyyy, hh:mm a').format(payment.paymentDate),
//                 style: TextStyle(
//                   fontSize: 13.sp,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             ),

//             // Reference
//             SizedBox(
//               width: 180.w,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       payment.reference,
//                       style: TextStyle(
//                         fontSize: 13.sp,
//                         color: Colors.grey.shade700,
//                         fontFamily: 'monospace',
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.copy, size: 16.sp),
//                     onPressed: () {
//                       Clipboard.setData(ClipboardData(text: payment.reference));
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Reference copied!'),
//                           duration: Duration(seconds: 1),
//                         ),
//                       );
//                     },
//                     padding: EdgeInsets.zero,
//                     constraints: const BoxConstraints(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }