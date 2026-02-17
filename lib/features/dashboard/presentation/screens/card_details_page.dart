import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:e_consular_card/features/auth/domain/entities/card_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';

class CardDetailPage extends StatelessWidget {
  final UserCardRequest cardRequest;

  const CardDetailPage({
    Key? key,
    required this.cardRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // appBar: CommonAppBar(
      //   title: "Transaction Details",
      //   showBackButton: true,
      //   // trailing: IconButton(
      //   //   icon: const Icon(Icons.share, color: Colors.white),
      //   //   onPressed: () {
      //   //     // TODO: Share transaction details
      //   //     ScaffoldMessenger.of(context).showSnackBar(
      //   //       const SnackBar(content: Text('Share feature coming soon!')),
      //   //     );
      //   //   },
      //   // ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStatusBanner(),
            SizedBox(height: 16.h),
            _buildDetailsCard(),
            SizedBox(height: 16.h),
            _buildTimelineCard(),
            SizedBox(height: 16.h),
            _buildActionButtons(context),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getStatusGradient(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Icon(
            _getStatusIcon(),
            size: 64.sp,
            color: Colors.white,
          ),
          SizedBox(height: 12.h),
          Text(
            cardRequest.statusText,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _getStatusMessage(),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
          Text(
            'Transaction Details',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20.h),
          _buildDetailRow(
            label: 'Service Name:',
            value: cardRequest.cardType,
            valueColor: Colors.black,
            valueFontWeight: FontWeight.w600,
          ),
          _buildDivider(),
          _buildDetailRow(
            label: 'Service Code:',
            value: 'ECC01',
            valueColor: AppColors.primary,
            valueFontWeight: FontWeight.w600,
          ),
          _buildDivider(),
          _buildDetailRow(
            label: 'Description:',
            value: cardRequest.description,
            valueColor: Colors.grey.shade700,
          ),
          _buildDivider(),
          _buildDetailRow(
            label: 'Amount:',
            value: '\$${cardRequest.totalAmount.toStringAsFixed(2)}',
            valueColor: AppColors.primary,
            valueFontWeight: FontWeight.w700,
            valueSize: 20.sp,
          ),
          _buildDivider(),
          _buildDetailRow(
            label: 'Status:',
            value: cardRequest.statusText,
            valueWidget: _buildStatusBadge(),
          ),
          _buildDivider(),
          _buildDetailRow(
            label: 'Transaction Date:',
            value: DateFormat('dd MMM yyyy').format(cardRequest.dateSubmitted),
            valueColor: Colors.black87,
          ),
          _buildDivider(),
          _buildDetailRow(
            label: 'Validity:',
            value: '2 years',
            valueColor: AppColors.info,
            valueFontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
          Text(
            'Request Timeline',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20.h),
          _buildTimelineItem(
            title: 'Request Submitted',
            date: DateFormat('dd MMM yyyy, HH:mm').format(cardRequest.dateSubmitted),
            isCompleted: true,
            isFirst: true,
          ),
          _buildTimelineItem(
            title: 'Payment Processed',
            date: DateFormat('dd MMM yyyy, HH:mm')
                .format(cardRequest.dateSubmitted.add(const Duration(minutes: 5))),
            isCompleted: true,
          ),
          _buildTimelineItem(
            title: 'Request Approved',
            date: cardRequest.status == RequestStatus.approved
                ? DateFormat('dd MMM yyyy, HH:mm')
                    .format(cardRequest.dateSubmitted.add(const Duration(hours: 2)))
                : 'Pending',
            isCompleted: cardRequest.status == RequestStatus.approved,
          ),
          _buildTimelineItem(
            title: 'Card Ready',
            date: cardRequest.status == RequestStatus.approved
                ? 'Within 5-7 business days'
                : 'Pending approval',
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String date,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.primary : Colors.grey.shade300,
                border: Border.all(
                  color: isCompleted ? AppColors.primary : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: isCompleted ? AppColors.primary : Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.black87 : Colors.grey,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          if (cardRequest.status == RequestStatus.approved) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Download card
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Download feature coming soon!'),
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Download Card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Contact support
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Support feature coming soon!'),
                  ),
                );
              },
              icon: const Icon(Icons.support_agent),
              label: const Text('Contact Support'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    String? value,
    Widget? valueWidget,
    Color? valueColor,
    FontWeight? valueFontWeight,
    double? valueSize,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: valueWidget ??
                Text(
                  value ?? '',
                  style: TextStyle(
                    fontSize: valueSize ?? 14.sp,
                    fontWeight: valueFontWeight ?? FontWeight.w500,
                    color: valueColor ?? Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.h,
      thickness: 1,
      color: Colors.grey.shade200,
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: cardRequest.statusBackgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        cardRequest.statusText,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: cardRequest.statusColor,
        ),
      ),
    );
  }

  List<Color> _getStatusGradient() {
    switch (cardRequest.status) {
      case RequestStatus.approved:
        return [AppColors.primary, AppColors.primaryLight];
      case RequestStatus.pending:
        return [Colors.orange, Colors.orange.shade300];
      case RequestStatus.rejected:
        return [Colors.red, Colors.red.shade300];
      case RequestStatus.processing:
        return [AppColors.info, Colors.blue.shade300];
    }
  }

  IconData _getStatusIcon() {
    switch (cardRequest.status) {
      case RequestStatus.approved:
        return Icons.check_circle;
      case RequestStatus.pending:
        return Icons.schedule;
      case RequestStatus.rejected:
        return Icons.cancel;
      case RequestStatus.processing:
        return Icons.pending;
    }
  }

  String _getStatusMessage() {
    switch (cardRequest.status) {
      case RequestStatus.approved:
        return 'Your card request has been approved';
      case RequestStatus.pending:
        return 'Your card request is being reviewed';
      case RequestStatus.rejected:
        return 'Your card request was not approved';
      case RequestStatus.processing:
        return 'Your card request is being processed';
    }
  }
}