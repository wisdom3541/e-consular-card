// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../domain/entities/payment.dart';

// class PaymentCard extends StatelessWidget {
//   final Payment payment;
//   final VoidCallback onTap;

//   const PaymentCard({
//     Key? key,
//     required this.payment,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12.h),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: Colors.grey.shade200),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Service Code
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                   decoration: BoxDecoration(
//                     color: AppColors.primary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(6.r),
//                   ),
//                   child: Text(
//                     payment.serviceCode,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ),
                
//                 // Status Badge
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                   decoration: BoxDecoration(
//                     color: payment.statusBackgroundColor,
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Text(
//                     payment.statusText,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w700,
//                       color: payment.statusColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
            
//             SizedBox(height: 12.h),
            
//             // Service Name
//             Text(
//               payment.serviceName,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
            
//             SizedBox(height: 12.h),
            
//             // Amount Row
//             Row(
//               children: [
//                 Icon(Icons.attach_money, size: 18.sp, color: AppColors.primary),
//                 SizedBox(width: 4.w),
//                 Text(
//                   'Amount',
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   '\$${payment.amount.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ],
//             ),
            
//             SizedBox(height: 8.h),
            
//             // Date Row
//             Row(
//               children: [
//                 Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey.shade500),
//                 SizedBox(width: 6.w),
//                 Text(
//                   'Payment Date',
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   DateFormat('dd MMM yyyy, hh:mm a').format(payment.paymentDate),
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
            
//             SizedBox(height: 8.h),
            
//             // Reference Row
//             Row(
//               children: [
//                 Icon(Icons.tag, size: 16.sp, color: Colors.grey.shade500),
//                 SizedBox(width: 6.w),
//                 Text(
//                   'Reference',
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   payment.reference,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey.shade700,
//                     fontFamily: 'monospace',
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 GestureDetector(
//                   onTap: () {
//                     Clipboard.setData(ClipboardData(text: payment.reference));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: const Text('Reference copied!'),
//                         duration: const Duration(seconds: 1),
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                       ),
//                     );
//                   },
//                   child: Icon(
//                     Icons.copy,
//                     size: 16.sp,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }