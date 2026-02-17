// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../domain/entities/payment.dart';

// class PaymentFilterChips extends StatelessWidget {
//   final PaymentStatus? selectedStatus;
//   final Function(PaymentStatus?) onFilterChanged;

//   const PaymentFilterChips({
//     Key? key,
//     required this.selectedStatus,
//     required this.onFilterChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           _buildFilterChip(
//             label: 'All',
//             isSelected: selectedStatus == null,
//             onTap: () => onFilterChanged(null),
//           ),
//           SizedBox(width: 8.w),
//           _buildFilterChip(
//             label: 'Success',
//             isSelected: selectedStatus == PaymentStatus.success,
//             onTap: () => onFilterChanged(PaymentStatus.success),
//             color: const Color(0xff24985B),
//           ),
//           SizedBox(width: 8.w),
//           _buildFilterChip(
//             label: 'Pending',
//             isSelected: selectedStatus == PaymentStatus.pending,
//             onTap: () => onFilterChanged(PaymentStatus.pending),
//             color: const Color(0xffFFA500),
//           ),
//           SizedBox(width: 8.w),
//           _buildFilterChip(
//             label: 'Failed',
//             isSelected: selectedStatus == PaymentStatus.failed,
//             onTap: () => onFilterChanged(PaymentStatus.failed),
//             color: const Color(0xffDC2626),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterChip({
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? (color ?? AppColors.primary)
//               : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(20.r),
//           border: Border.all(
//             color: isSelected
//                 ? (color ?? AppColors.primary)
//                 : Colors.grey.shade300,
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//             color: isSelected ? Colors.white : Colors.grey.shade700,
//           ),
//         ),
//       ),
//     );
//   }
// }