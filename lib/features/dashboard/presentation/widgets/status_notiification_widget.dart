import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum NotificationType {
  success,
  info,
  warning,
  error,
}

class StatusNotificationWidget extends StatelessWidget {
  final NotificationType type;
  final String title;
  final String message;
  final String? code;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showCopyButton;
  final bool dismissible;
  final VoidCallback? onDismiss;

  const StatusNotificationWidget({
    Key? key,
    required this.type,
    required this.title,
    required this.message,
    this.code,
    this.icon,
    this.onTap,
    this.showCopyButton = true,
    this.dismissible = false,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    Widget content = Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors['background'],
        border: Border.all(
          color: colors['border']!,
          width: 1.5,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          // if (icon != null) ...[
          //   Container(
          //     padding: EdgeInsets.all(8.w),
          //     decoration: BoxDecoration(
          //       color: colors['iconBg'],
          //       borderRadius: BorderRadius.circular(8.r),
          //     ),
          //     child: Icon(
          //       icon,
          //       size: 24.sp,
          //       color: colors['iconColor'],
          //     ),
          //   ),
          //   SizedBox(width: 12.w),
          // ],

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: colors['titleColor'],
                  ),
                ),

                if (code != null) ...[
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        'Delivery Code: ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: colors['textColor'],
                        ),
                      ),
                      Text(
                        code!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: colors['codeColor'],
                         // letterSpacing: 1.2,
                        ),
                      ),
                      if (showCopyButton) ...[
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () => _copyToClipboard(context, code!),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: colors['buttonBg'],
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.copy,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],

                SizedBox(height: 8.h),

                // Message
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: colors['textColor'],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Dismiss button
          if (dismissible && onDismiss != null) ...[
            SizedBox(width: 8.w),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 18.sp,
                color: colors['textColor'],
              ),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: content,
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: content,
    );
  }

  Map<String, Color> _getColors() {
    switch (type) {
      case NotificationType.success:
        return {
          'background': const Color(0xFFE8F5E9),
          'border': const Color(0xFF81C784),
          'titleColor': const Color(0xFF2E7D32),
          'textColor': const Color(0xFF388E3C),
          'codeColor': const Color(0xFF1B5E20),
          'iconColor': const Color(0xFF2E7D32),
          'iconBg': const Color(0xFFC8E6C9),
          'buttonBg': const Color(0xFF66BB6A),
        };
      case NotificationType.info:
        return {
          'background': const Color(0xFFE3F2FD),
          'border': const Color(0xFF64B5F6),
          'titleColor': const Color(0xFF1565C0),
          'textColor': const Color(0xFF1976D2),
          'codeColor': const Color(0xFF0D47A1),
          'iconColor': const Color(0xFF1565C0),
          'iconBg': const Color(0xFFBBDEFB),
          'buttonBg': const Color(0xFF42A5F5),
        };
      case NotificationType.warning:
        return {
          'background': const Color(0xFFFFF8E1),
          'border': const Color(0xFFFFD54F),
          'titleColor': const Color(0xFFF57F17),
          'textColor': const Color(0xFFF9A825),
          'codeColor': const Color(0xFFE65100),
          'iconColor': const Color(0xFFF57F17),
          'iconBg': const Color(0xFFFFECB3),
          'buttonBg': const Color(0xFFFFCA28),
        };
      case NotificationType.error:
        return {
          'background': const Color(0xFFFFEBEE),
          'border': const Color(0xFFE57373),
          'titleColor': const Color(0xFFC62828),
          'textColor': const Color(0xFFD32F2F),
          'codeColor': const Color(0xFFB71C1C),
          'iconColor': const Color(0xFFC62828),
          'iconBg': const Color(0xFFFFCDD2),
          'buttonBg': const Color(0xFFEF5350),
        };
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code $text copied!'),
        duration: const Duration(seconds: 2),
        backgroundColor: _getColors()['titleColor'],
      ),
    );
  }
}