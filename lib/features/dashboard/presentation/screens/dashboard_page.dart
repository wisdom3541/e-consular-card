import 'package:e_consular_card/core/utils/date_helper.dart';
import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:e_consular_card/features/auth/domain/entities/card_services.dart';
import 'package:e_consular_card/features/auth/presentation/providers/auth_provider.dart';
import 'package:e_consular_card/features/auth/presentation/screens/complete_registration_page.dart';
import 'package:e_consular_card/features/auth/presentation/screens/login_page.dart';
import 'package:e_consular_card/features/dashboard/presentation/screens/card_request_page.dart';
import 'package:e_consular_card/features/dashboard/data/models/dashboard_response.dart';
import 'package:e_consular_card/features/dashboard/presentation/screens/card_details_page.dart';
import 'package:e_consular_card/features/dashboard/presentation/widgets/approved_card_widget.dart';
import 'package:e_consular_card/features/dashboard/presentation/widgets/status_notiification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Logout
              final authProvider = context.read<AuthProvider>();
              await authProvider.logout();

              if (!mounted) return;

              // Navigate to login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        trailing: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.green,
          ),
          onSelected: (value) {
            if (value == 'logout') {
              _handleLogout();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Logout', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
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
                    // Active Card Section
                    if (provider.hasActiveCard && provider.cardStatus != null)
                      _buildActiveCardSection(provider.cardStatus!, context),

                    // Smart Card Status Notifications - UPDATED
                    ..._buildCardStatusNotifications(provider, context),
                    SizedBox(height: 20.h),

                    // Stats cards
                    if (provider.stats != null) ...[
                      _buildStatsCards(provider.stats!),
                      SizedBox(height: 20.h),
                    ],

                    // Recent transactions
                    if (provider.recentTransactions.isNotEmpty) ...[
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ...provider.recentTransactions.map((transaction) {
                        return _buildTransactionCard(transaction);
                      }),
                    ],

                    // Text(
                    //   'Requests and Transactions',
                    //   style: TextStyle(
                    //     fontSize: 18.sp,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    // SizedBox(height: 16.h),

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: FilterTabs(
                    //     selectedFilter: provider.selectedFilter,
                    //     allCount: provider.allRequestsCount,
                    //     pendingCount: provider.pendingCount,
                    //     approvedCount: provider.approvedCount,
                    //     onFilterChanged: (filter) {
                    //       context.read<DashboardProvider>().setFilter(filter);
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 20.h),

                    //    _buildContent(provider),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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

  Widget _buildAppprovedIdCardBanner(DashboardProvider provider) {
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
          ApprovedCardDetailsWidget(
            title: 'Your card has been printed!',
            deliveryCode: provider.user!.regOrigin!,
            message: 'Please use this code to collect your card delivery.',
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
                  'Card Request Under Review',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange.shade900,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Your card request is being reviewed. You will be notified once it\'s approved.',
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

  List<Widget> _buildCardStatusNotifications(
      DashboardProvider provider, BuildContext context) {
    List<Widget> notifications = [];

    final user = provider.user;
    if (user == null) return notifications;

    // Get card status from provider (not user)
    final cardReqStatus = provider.cardReqStatus;
    final cardStatus = provider.cardStatus;

    // Priority 1: Registration Status (if incomplete or rejected)
    if (user.regStatus.toUpperCase() == 'INCOMPLETE') {
      return notifications;
    }

    // if (user.isRejected) {
    //   notifications.add(
    //     StatusNotificationWidget(
    //       type: NotificationType.error,
    //       title: 'Registration Rejected',
    //       message: user.rejectionReason ?? 'Your registration was rejected. Please contact support for assistance.',
    //       icon: Icons.cancel_outlined,
    //     ),
    //   );
    //   return notifications;
    // }

    // if (user.isPending) {
    //   notifications.add(
    //     StatusNotificationWidget(
    //       type: NotificationType.warning,
    //       title: 'Registration Pending Approval',
    //       message: 'Your registration is under review. You will be notified once approved.',
    //       icon: Icons.pending_outlined,
    //     ),
    //   );
    //   return notifications;
    // }

    // Priority 2: Card Delivery (if printed and needs collection)
    if (cardStatus != null && cardStatus.needsDeliveryCode) {
      notifications.add(
        StatusNotificationWidget(
          type: NotificationType.success,
          title: 'Your card has been printed!',
          code: cardStatus.deliveryCode!,
          message: cardStatus.hasPaidDelivery
              ? 'Your card will be delivered to your address. Use this code to track your delivery.'
              : 'Please use this code to collect your card at the consular office.',
          icon: Icons.check_circle_outline,
        ),
      );
    }

    // Priority 3: Card Delivered
    if (cardStatus != null && cardStatus.isDelivered) {
      notifications.add(
        StatusNotificationWidget(
          type: NotificationType.success,
          title: 'Card Delivered',
          code: cardStatus.cardNo,
          message:
              'Your E-Consular Card has been delivered successfully. Card Number: ${cardStatus.cardNo}',
          icon: Icons.card_membership,
          showCopyButton: true,
        ),
      );
    }

    // Priority 4: Card Request Status
    if (cardReqStatus != null &&
        cardReqStatus != 'false' &&
        cardReqStatus.toUpperCase() != 'APPROVED') {
      if (cardReqStatus.toUpperCase() == 'PENDING') {

        notifications.add(
          
          _buildPendingApprovalBanner()
          
          );
      } else if (cardReqStatus.toUpperCase() == 'REJECTED') {
        notifications.add(
            // StatusNotificationWidget(
            //   type: NotificationType.error,
            //   title: 'Card Request Rejected',
            //   message: 'Your card request was rejected. Please contact support or submit a new request.',
            //   icon: Icons.error_outline,
            // ),
            _buildRejectedBanner(provider.cardStatus?.note));
      } else if (cardReqStatus.toUpperCase() == 'PROCESSING') {
        notifications.add(_buildAppprovedIdCardBanner(provider));
      }
    }

    // Priority 5: No Card Yet (Approved user with no card request)
    if (!provider.hasCardRequest &&
        (cardStatus == null || cardStatus.status == 'none')) {
      notifications.add(_buildIdCardBanner());
    }

    // Priority 6: Card Expiring Soon
    if (cardStatus?.card?.expirationDate != null) {
      try {
        final expirationDate = DateTime.parse(cardStatus!.card!.expirationDate);
        final daysUntilExpiry =
            expirationDate.difference(DateTime.now()).inDays;

        if (daysUntilExpiry > 0 && daysUntilExpiry <= 30) {
          notifications.add(
            StatusNotificationWidget(
              type: NotificationType.warning,
              title: 'Card Expiring Soon',
              message:
                  'Your card will expire in $daysUntilExpiry days. Please request a renewal.',
              icon: Icons.warning_amber_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardRequestPage(),
                  ),
                );
              },
            ),
          );
        } else if (daysUntilExpiry <= 0) {
          notifications.add(
            StatusNotificationWidget(
              type: NotificationType.error,
              title: 'Card Expired',
              message:
                  'Your card has expired. Please request a new card to continue using our services.',
              icon: Icons.error_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardRequestPage(),
                  ),
                );
              },
            ),
          );
        }
      } catch (e) {
        print('Error parsing expiration date: $e');
      }
    }

    return notifications;
  }

  Widget _buildActiveCardSection(CardStatus cardStatus, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.7),
          ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row - Title and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'E-Consular Card',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  cardStatus.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Card Number Section
          Text(
            'Card Number',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  cardStatus.cardNo,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: cardStatus.cardNo));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Card number copied!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.copy,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Card Status Info Row
          Row(
            children: [
              // Printed Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Printed',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          cardStatus.printed
                              ? Icons.check_circle
                              : Icons.pending,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          cardStatus.printed ? 'Yes' : 'No',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Delivered Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivered',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          cardStatus.delivered
                              ? Icons.check_circle
                              : Icons.pending,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          cardStatus.delivered ? 'Yes' : 'No',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Expiration Date (if available)
          if (cardStatus.card?.expirationDate != null) ...[
            SizedBox(height: 16.h),
            Text(
              'Expires',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              DateHelper.formatDate(
                cardStatus.card!.expirationDate,
              ),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
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

  Widget _buildPrintedCardBanner(CardStatus cardStatus) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green
        border: Border.all(
          color: const Color(0xFF81C784), // Green border
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Your card has been printed!',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2E7D32), // Dark green
            ),
          ),

          SizedBox(height: 8.h),

          // Delivery Code with Copy Button
          Row(
            children: [
              Text(
                'Delivery Code: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF388E3C), // Medium green
                ),
              ),
              Text(
                cardStatus.deliveryCode!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1B5E20), // Darker green
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: cardStatus.deliveryCode!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Delivery code ${cardStatus.deliveryCode!} copied!'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: const Color(0xFF2E7D32),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF66BB6A),
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
          ),

          SizedBox(height: 8.h),

          // Message
          Text(
            cardStatus.hasPaidDelivery
                ? 'Your card will be delivered to your address. Use this code to track your delivery.'
                : 'Please use this code to collect your card at the consular office.',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF388E3C),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
