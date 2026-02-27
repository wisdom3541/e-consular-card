import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:e_consular_card/features/support/presentation/screens/ticket_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/support_provider.dart';
import '../widgets/create_ticket_dialog.dart';
import '../../data/models/support_ticket_models.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool _isCardView = true;

  @override
  void initState() {
    super.initState();
    // Load tickets on page load
  
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupportProvider>().loadTickets();
     });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SupportProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _CommonAppBar(
        title: "Support",
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                _isCardView ? Icons.table_rows : Icons.view_agenda,
                color: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  _isCardView = !_isCardView;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: () => _showCreateTicketDialog(),
            ),
          ],
        ),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(SupportProvider provider) {
    if (provider.isLoading && provider.tickets.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null && provider.tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                provider.errorMessage!,
                style: TextStyle(fontSize: 14.sp, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => provider.loadTickets(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.tickets.isEmpty) {
      return _buildEmptyState(provider);
    }

    return RefreshIndicator(
      onRefresh: () => provider.refresh(),
      child: Column(
        children: [
          // Stats Card
      //    _buildStatsCard(provider),
      SizedBox(height: 10.h),

          // Filters
          _buildFilters(provider),

          // Tickets List
          Expanded(
            child: _isCardView
                ? _buildCardView(provider)
                : _buildTableView(provider),
          ),

          // Load More Button
          if (provider.hasMorePages)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () => provider.loadMoreTickets(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: provider.isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Load More', style: TextStyle(color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(SupportProvider provider) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', provider.totalTickets.toString(), Colors.white),
          _buildStatItem('Pending', provider.pendingCount.toString(), Colors.white),
          _buildStatItem('In Progress', provider.inProgressCount.toString(), Colors.white),
          _buildStatItem('Resolved', provider.resolvedCount.toString(), Colors.white),
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
            fontSize: 11.sp,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(SupportProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              'Status:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            _buildFilterChip('All', null, provider, isStatus: true),
            SizedBox(width: 8.w),
            _buildFilterChip('Pending', 'pending', provider, isStatus: true),
            SizedBox(width: 8.w),
            _buildFilterChip('In Progress', 'in_progress', provider, isStatus: true),
            SizedBox(width: 8.w),
            _buildFilterChip('Resolved', 'resolved', provider, isStatus: true),
            SizedBox(width: 16.w),
            Text(
              'Priority:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            _buildFilterChip('High', 'high', provider, isStatus: false),
            SizedBox(width: 8.w),
            _buildFilterChip('Medium', 'medium', provider, isStatus: false),
            SizedBox(width: 8.w),
            _buildFilterChip('Low', 'low', provider, isStatus: false),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String? value,
    SupportProvider provider, {
    required bool isStatus,
  }) {
    final isSelected = isStatus
        ? (value == null && provider.statusFilter == null) ||
            value == provider.statusFilter
        : value == provider.priorityFilter;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (isStatus) {
          provider.setStatusFilter(selected ? value : null);
        } else {
          provider.setPriorityFilter(selected ? value : null);
        }
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
    );
  }

  Widget _buildCardView(SupportProvider provider) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: provider.tickets.length,
      itemBuilder: (context, index) {
        final ticket = provider.tickets[index];
        return _buildTicketCard(ticket);
      },
    );
  }

  Widget _buildTicketCard(SupportTicket ticket) {
    return GestureDetector(
      onTap: () => _navigateToTicketDetails(ticket),
      child: Container(
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
            // Header: Status and Priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ticket.statusBackgroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    ticket.displayStatus,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: ticket.statusColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ticket.priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    ticket.displayPriority,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: ticket.priorityColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Subject
            Text(
              ticket.subject,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8.h),

            // Category
            Row(
              children: [
                Icon(Icons.category_outlined, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  ticket.category,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // Date
            Row(
              children: [
                Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  DateFormat('dd MMM yyyy, hh:mm a').format(
                    DateTime.parse(ticket.createdAt),
                  ),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableView(SupportProvider provider) {
    // Similar implementation to PaymentTable
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: _buildTicketsTable(provider.tickets),
      ),
    );
  }

  Widget _buildTicketsTable(List<SupportTicket> tickets) {
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
        columns: [
          DataColumn(label: Text('Subject', style: _tableHeaderStyle)),
          DataColumn(label: Text('Category', style: _tableHeaderStyle)),
          DataColumn(label: Text('Priority', style: _tableHeaderStyle)),
          DataColumn(label: Text('Status', style: _tableHeaderStyle)),
          DataColumn(label: Text('Date', style: _tableHeaderStyle)),
        ],
        rows: tickets.map((ticket) {
          return DataRow(
            cells: [
              DataCell(
                Container(
                  constraints: BoxConstraints(maxWidth: 200.w),
                  child: Text(
                    ticket.subject,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                onTap: () => _navigateToTicketDetails(ticket),
              ),
              DataCell(Text(ticket.category, style: TextStyle(fontSize: 13.sp))),
              DataCell(
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ticket.priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    ticket.displayPriority,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: ticket.priorityColor,
                    ),
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ticket.statusBackgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    ticket.displayStatus,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: ticket.statusColor,
                    ),
                  ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('dd MMM yyyy').format(DateTime.parse(ticket.createdAt)),
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  TextStyle get _tableHeaderStyle => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  Widget _buildEmptyState(SupportProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
           // Filters
          _buildFilters(provider),
          Spacer(),
          Icon(
            Icons.support_agent_outlined,
            size: 100.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 20.h),
          Text(
            'No support tickets yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create a ticket to get help from support',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: _showCreateTicketDialog,
            icon: const Icon(Icons.add),
            label: const Text('Create Ticket'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
          Spacer(flex: 2,),
        ],
      ),
    );
  }

  void _showCreateTicketDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateTicketDialog(),
    );
  }

  void _navigateToTicketDetails(SupportTicket ticket) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketDetailsPage(ticket: ticket),
      ),
    );
  }
}





class _CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final bool showBackButton;
  final Color titleColor;

  const _CommonAppBar({
    Key? key,
    this.title = "E-Consular Card",
    this.trailing,
    this.showBackButton = false,
    this.titleColor = AppColors.primaryDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, ),
      color: AppColors.textWhite,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: trailing == null ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
                onPressed: () => Navigator.pop(context),
              )
            else
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w800,
                  
                ),
              ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(78.h);
}