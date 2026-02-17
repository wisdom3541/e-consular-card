import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/ticket.dart';

class SupportTable extends StatelessWidget {
  final List<SupportTicket> tickets;
  final Function(SupportTicket) onTicketTap;

  const SupportTable({
    Key? key,
    required this.tickets,
    required this.onTicketTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 1000.w, // Fixed width for table
          child: Column(
            children: [
              _buildTableHeader(),
              ...tickets.map((ticket) => _buildTableRow(ticket, context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: _buildHeaderText('TICKET ID'),
          ),
          SizedBox(
            width: 200.w,
            child: _buildHeaderText('SUBJECT'),
          ),
          SizedBox(
            width: 140.w,
            child: _buildHeaderText('CATEGORY'),
          ),
          SizedBox(
            width: 120.w,
            child: _buildHeaderText('PRIORITY'),
          ),
          SizedBox(
            width: 120.w,
            child: _buildHeaderText('STATUS'),
          ),
          SizedBox(
            width: 220.w,
            child: _buildHeaderText('CREATED AT'),
          ),
          SizedBox(
            width: 100.w,
            child: _buildHeaderText('ACTION'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTableRow(SupportTicket ticket, BuildContext context) {
    return GestureDetector(
      onTap: () => onTicketTap(ticket),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            // Ticket ID
            SizedBox(
              width: 100.w,
              child: Text(
                '#${ticket.id}',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),

            // Subject
            SizedBox(
              width: 200.w,
              child: Text(
                ticket.subject,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Category
            SizedBox(
              width: 140.w,
              child: Text(
                ticket.categoryText,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            // Priority
            SizedBox(
              width: 120.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ticket.priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: ticket.priorityColor.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  ticket.priorityText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ticket.priorityColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Status
            SizedBox(
              width: 120.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ticket.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  ticket.statusText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ticket.statusColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Created At
            SizedBox(
              width: 220.w,
              child: Text(
                DateFormat('dd MMM yyyy, hh:mm a').format(ticket.createdAt),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            // Action
            SizedBox(
              width: 100.w,
              child: IconButton(
                icon: Icon(
                  Icons.visibility,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
                onPressed: () => onTicketTap(ticket),
              ),
            ),
          ],
        ),
      ),
    );
  }
}