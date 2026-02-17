import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:e_consular_card/features/auth/domain/entities/card_services.dart';
import 'package:e_consular_card/features/auth/presentation/screens/complete_registration_page.dart';
import 'package:e_consular_card/features/dashboard/presentation/screens/card_request_page.dart';
import 'package:e_consular_card/features/dashboard/data/models/dashboard_response.dart';
import 'package:e_consular_card/features/dashboard/presentation/screens/card_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/filter_tabs.dart';
import '../widgets/card_request_item.dart';
import '../widgets/empty_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  bool _hasCheckedRegStatus = false; 


  @override
  void initState() {
    super.initState();
    // ✅ Use read for one-time method calls
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboardData();
    });
  }


 
  void _checkRegistrationStatus(DashboardUser user) {
    // Only show dialog if registration is actually incomplete
    if (user.regStatus.toUpperCase() == 'INCOMPLETE') {
      // Use addPostFrameCallback to ensure dialog shows after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showIncompleteRegistrationDialog();
        }
      });
    }
  }
  // Add this method
  void _showIncompleteRegistrationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must complete registration
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 28.sp,
            ),
            SizedBox(width: 12.w),
            const Text('Complete Registration'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your registration is incomplete. Please complete your registration to access all features.',
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'You need to complete your personal information and next of kin details.',
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
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              
              // Navigate to complete registration
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CompleteRegistrationPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text(
              'Complete Registration',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCardRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CardRequestPage(),
      ),
    ).then((_) {
      // ✅ Use read for method call
      context.read<DashboardProvider>().loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        trailing: IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.primaryDark,
            size: 30,
          ),
          onPressed: () {
            // TODO: Navigate to notifications
          },
        ),
      ),
      // ✅ Use Builder to get new context, then watch
      body: Builder(
        builder: (context) {
          // ✅ Watch here so UI rebuilds when data changes
          final provider = context.watch<DashboardProvider>();


    // Check registration status after data loads
   if (provider.hasDashboardData && 
        provider.user != null && 
        !_hasCheckedRegStatus &&
        !provider.registrationManuallyCompleted) {
      _hasCheckedRegStatus = true;
      _checkRegistrationStatus(provider.user!);
    }

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
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
                    onPressed: () => provider.loadDashboardData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
        _hasCheckedRegStatus = false; // Reset flag on refresh
        await provider.loadDashboardData();
      },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeText(provider.userName),
                    SizedBox(height: 20.h),

                    // Show banner based on approval status
                    if (provider.user != null) ...[
                      if (provider.user!.isPending)
                        _buildPendingApprovalBanner()
                      else if (provider.user!.isApproved &&
                          provider.stats?.total == 0)
                        _buildIdCardBanner()
                      else if (provider.user!.isRejected)
                        _buildRejectedBanner(provider.user!.rejectionReason),
                      SizedBox(height: 20.h),
                    ],

                    // Stats cards
                    if (provider.stats != null) ...[
                      _buildStatsCards(provider.stats!),
                      SizedBox(height: 20.h),
                    ],

                    // Recent transactions
                    // if (provider.recentTransactions.isNotEmpty) ...[
                    //   Text(
                    //     'Recent Transactions',
                    //     style: TextStyle(
                    //       fontSize: 18.sp,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                    //   SizedBox(height: 16.h),
                    //   ...provider.recentTransactions.map((transaction) {
                    //     return _buildTransactionCard(transaction);
                    //   }),
                    // ],

                    // if (!provider.hasCardRequest) ...[
                    //   _buildIdCardBanner(),
                    //   SizedBox(height: 20.h),
                    // ],

                    // if (provider.hasCardRequest) ...[
                    //   _buildPendingStatusBanner(),
                    //   SizedBox(height: 20.h),
                    // ],

                    Text(
                      'Requests and Transactions',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FilterTabs(
                        selectedFilter: provider.selectedFilter,
                        allCount: provider.allRequestsCount,
                        pendingCount: provider.pendingCount,
                        approvedCount: provider.approvedCount,
                        onFilterChanged: (filter) {
                          context.read<DashboardProvider>().setFilter(filter);
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),

                    _buildContent(provider),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Rest of your methods stay the same...
  Widget _buildWelcomeText(String userName) {
    return Wrap(
      children: [
        Text(
          "Welcome, ",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        Text(
          userName,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildIdCardBanner() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Identity, Simplified:\nYour National ID Awaits",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Request your ID easily on our platform. Have it ready in less than a week!",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Image.asset(
                "images/cardimage.png",
                height: 70.h,
                width: 90.w,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.credit_card,
                    size: 70.sp,
                    color: AppColors.primary,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _navigateToCardRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text(
                'Request ID Card Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(DashboardProvider provider) {
    if (!provider.hasCardRequest) {
      return EmptyState(onRequestCard: _navigateToCardRequest);
    }

    final shouldShow = _shouldShowRequest(
      provider.userCardRequest!,
      provider.selectedFilter,
    );

    if (!shouldShow) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Text(
            'No requests found for this filter',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return CardRequestItem(
      request: provider.userCardRequest!,
      onTap: () {
        // Navigate to card detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailPage(
              cardRequest: provider.userCardRequest!,
            ),
          ),
        );
      },
    );
  }

  bool _shouldShowRequest(UserCardRequest request, FilterType filter) {
    switch (filter) {
      case FilterType.all:
        return true;
      case FilterType.pending:
        return request.status == RequestStatus.pending;
      case FilterType.approved:
        return request.status == RequestStatus.approved;
    }
  }
}



Widget _buildPendingApprovalBanner() {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Row(
      children: [
        Icon(
          Icons.pending_actions,
          color: Colors.orange,
          size: 22.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Registration Pending Approval',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange.shade900,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Your registration is under review. You will be notified once approved.',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRejectedBanner(String? reason) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Row(
      children: [
        Icon(
          Icons.cancel,
          color: Colors.red,
          size: 32.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Registration Rejected',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade900,
                ),
              ),
              if (reason != null) ...[
                SizedBox(height: 4.h),
                Text(
                  'Reason: $reason',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.red.shade800,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatsCards(DashboardStats stats) {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          'Total',
          stats.total.toString(),
          AppColors.primary,
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: _buildStatCard(
          'Paid',
          stats.paid.toString(),
          Colors.green,
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: _buildStatCard(
          'Pending',
          stats.pending.toString(),
          Colors.orange,
        ),
      ),
    ],
  );
}

Widget _buildStatCard(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransactionCard(RecentTransaction transaction) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                transaction.description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              transaction.status,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
