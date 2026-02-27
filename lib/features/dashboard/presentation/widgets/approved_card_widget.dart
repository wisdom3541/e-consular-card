import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApprovedCardDetailsWidget extends StatelessWidget {
  final String title;
  final String deliveryCode;
  final String message;
  final VoidCallback? onTap;
  final bool showCopyButton;

  const ApprovedCardDetailsWidget({
    super.key,
    required this.title,
    required this.deliveryCode,
    required this.message,
    this.onTap,
    this.showCopyButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green background
        border: Border.all(
          color: const Color(0xFF81C784), // Green border
         // width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2E7D32), // Dark green
            ),
          ),

          SizedBox(height: 4.h),

          // Delivery Code with Copy Button
          Row(
            children: [
              Text(
                'Delivery Code: ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF388E3C), // Medium green
                ),
              ),
              Text(
                deliveryCode,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1B5E20), // Darker green
                  letterSpacing: 1.2,
                ),
              ),
              if (showCopyButton) ...[
                SizedBox(width: 8.w),
                InkWell(
                  onTap: () => _copyToClipboard(context, deliveryCode),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF66BB6A),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(
                      Icons.copy,
                      size: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 4.h),

          // Message
          Text(
            message,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF388E3C),
              //height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Delivery code $code copied!'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF2E7D32),
      ),
    );
  }
}