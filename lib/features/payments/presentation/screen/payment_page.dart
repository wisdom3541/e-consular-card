import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:e_consular_card/features/payments/data/models/payment_history_response.dart';
import 'package:e_consular_card/features/payments/presentation/widget/payment_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/payment_provider.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}



class _PaymentsPageState extends State<PaymentsPage> {
  bool _isTableView = false;

  @override
  void initState() {
    super.initState();
    // Load payment history on page load
    Future.microtask(() {
      context.read<PaymentProvider>().loadPaymentHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        // appBar: CommonAppBar(
        //   title: "Payment History",
        //   trailing: IconButton(
        //     icon: Icon(
        //       _isTableView ? Icons.view_agenda : Icons.table_rows,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         _isTableView = !_isTableView;
        //       });
        //     },
        //   ),
        // ),
        body: _buildBody(provider),
      ),
    );
  }

  Widget _buildBody(PaymentProvider provider) {
    if (provider.isLoading && provider.payments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null && provider.payments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              provider.errorMessage!,
              style: TextStyle(fontSize: 14.sp, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => provider.loadPaymentHistory(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.refresh(),
      child: Column(
        children: [
          // Summary Card
          _buildSummaryCard(provider),

          // Search & Filters
          _buildSearchAndFilters(provider),

          // Payments List
          Expanded(
            child: provider.payments.isEmpty
                ? _buildEmptyState()
                : _isTableView
                    ? _buildTableView(provider)
                    : _buildCardView(provider),
          ),

          // Load More Button (if pagination available)
          if (provider.hasMorePages)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () => provider.loadMorePayments(),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Load More'),
              ),
            ),
        ],
      ),
    );
  }
  

 Widget _buildSummaryCard(PaymentProvider provider) {
  return Container(
    margin: EdgeInsets.all(16.w),
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          '\$${provider.totalAmount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Successfully Paid', // UPDATED TEXT
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              'Total',
              provider.payments.length.toString(),
              Colors.white,
            ),
            _buildStatItem(
              'Success',
              provider.successCount.toString(),
              Colors.white,
            ),
            _buildStatItem(
              'Pending',
              provider.pendingCount.toString(),
              Colors.white,
            ),
            _buildStatItem(
              'Failed',
              provider.failedCount.toString(),
              Colors.white,
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters(PaymentProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search by reference or service...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              provider.setSearchQuery(value);
            },
          ),

          SizedBox(height: 12.h),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', null, provider),
                SizedBox(width: 8.w),
                _buildFilterChip('Success', 'success', provider),
                SizedBox(width: 8.w),
                _buildFilterChip('Pending', 'pending', provider),
                SizedBox(width: 8.w),
                _buildFilterChip('Failed', 'failed', provider),
              ],
            ),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
  String label,
  String? status,
  PaymentProvider provider,
) {
  final isSelected = (status == null && provider.statusFilter == null) || // UPDATED
      status == provider.statusFilter; // UPDATED

  return FilterChip(
    label: Text(label),
    selected: isSelected,
    onSelected: (selected) {
      provider.setStatusFilter(selected ? status : null);
    },
    selectedColor: AppColors.primary.withOpacity(0.2),
    checkmarkColor: AppColors.primary,
  );
}
  Widget _buildCardView(PaymentProvider provider) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: provider.payments.length,
      itemBuilder: (context, index) {
        final payment = provider.payments[index];
        return _buildPaymentCard(payment);
      },
    );
  }

  Widget _buildPaymentCard(PaymentHistoryItem payment) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Service Code Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  payment.meta.servicesDisplay,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),

              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: payment.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  payment.displayStatus,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: payment.statusColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Amount
          Text(
            '\$${payment.meta.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 8.h),

          // Date
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
              SizedBox(width: 6.w),
              Text(
                DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.parse(payment.createdAt),
                ),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Reference with Copy Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Ref: ${payment.reference}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.copy, size: 16.sp),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: payment.reference));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reference copied!')),
                  );
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableView(PaymentProvider provider) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: _buildPaymentTable(provider.payments),
    ),
  );
}

Widget _buildPaymentTable(List<PaymentHistoryItem> payments) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: DataTable(
      headingRowColor: MaterialStateProperty.all(
        AppColors.primary.withOpacity(0.1),
      ),
      headingRowHeight: 50.h,
      dataRowHeight: 60.h,
      columnSpacing: 20.w,
      horizontalMargin: 20.w,
      columns: [
        DataColumn(
          label: Text(
            'Service',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Reference',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Amount',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Date',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Status',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Actions',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
      rows: payments.map((payment) {
        return DataRow(
          cells: [
            // Service
            DataCell(
              Container(
                constraints: BoxConstraints(maxWidth: 150.w),
                child: Text(
                  payment.meta.servicesDisplay,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Reference
            DataCell(
              Row(
                children: [
                  Text(
                    payment.reference,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: payment.reference));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Reference copied!')),
                      );
                    },
                    child: Icon(
                      Icons.copy,
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            DataCell(
              Text(
                '\$${payment.meta.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),

            // Date
            DataCell(
              Text(
                DateFormat('dd MMM yyyy').format(
                  DateTime.parse(payment.createdAt),
                ),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            // Status
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: payment.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  payment.displayStatus,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: payment.statusColor,
                  ),
                ),
              ),
            ),

            // Actions
            DataCell(
              IconButton(
                icon: const Icon(Icons.more_vert),
                iconSize: 20.sp,
                onPressed: () {
                  _showPaymentActions(context, payment);
                },
              ),
            ),
          ],
        );
      }).toList(),
    ),
  );
}


void _showPaymentActions(BuildContext context, PaymentHistoryItem payment) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('View Details'),
            onTap: () {
              Navigator.pop(context);
              _showPaymentDetails(context, payment);
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy Reference'),
            onTap: () {
              Clipboard.setData(ClipboardData(text: payment.reference));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reference copied!')),
              );
            },
          ),
          if (payment.meta.status.toLowerCase() == 'failed')
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Retry Payment'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Retry payment
              },
            ),
        ],
      ),
    ),
  );
}


void _showPaymentDetails(BuildContext context, PaymentHistoryItem payment) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: const Text('Payment Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Reference', payment.reference),
            SizedBox(height: 12.h),
            _buildDetailRow('Amount', '\$${payment.meta.amount.toStringAsFixed(2)}'),
            SizedBox(height: 12.h),
            _buildDetailRow('Service', payment.meta.servicesDisplay),
            SizedBox(height: 12.h),
            _buildDetailRow(
              'Date',
              DateFormat('dd MMM yyyy, hh:mm a').format(
                DateTime.parse(payment.createdAt),
              ),
            ),
            SizedBox(height: 12.h),
            _buildDetailRow('Status', payment.displayStatus),
            if (payment.meta.verifiedAt != null) ...[
              SizedBox(height: 12.h),
              _buildDetailRow(
                'Verified At',
                DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.parse(payment.meta.verifiedAt!),
                ),
              ),
            ],
            SizedBox(height: 12.h),
            _buildDetailRow(
              'Delivery',
              payment.meta.paidDelivery ? 'Yes' : 'No',
            ),
            SizedBox(height: 12.h),
            _buildDetailRow(
              'Transaction ID',
              payment.meta.transactionIds.join(', '),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey.shade600,
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        value,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payment_outlined,
            size: 100.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 20.h),
          Text(
            'No payments yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your payment history will appear here',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }}