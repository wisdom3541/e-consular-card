import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/support_provider.dart';
import '../widgets/create_ticket_dialog.dart';
import '../widgets/ticket_card.dart';
import '../widgets/support_table.dart';
import '../../domain/entities/ticket.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool _isTableView = false; // Toggle between card and table view

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SupportProvider>().loadTickets();
    });
  }

  void _showCreateTicketDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateTicketDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SupportProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CommonAppBar(
        title: "Support Tickets",
        // trailing: IconButton(
        //   icon: Icon(
        //     _isTableView ? Icons.view_agenda : Icons.table_rows,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       _isTableView = !_isTableView;
        //     });
        //   },
        // ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
              ? _buildErrorView(provider)
              : _buildContent(provider),
    );
  }

  Widget _buildErrorView(SupportProvider provider) {
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
            onPressed: () => provider.loadTickets(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(SupportProvider provider) {
    return Column(
      children: [
        // Header with New Ticket Button
        Container(
          padding: EdgeInsets.all(20.w),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Support Tickets',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showCreateTicketDialog,
                icon: const Icon(Icons.add, size: 20),
                label: const Text('New Ticket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: provider.hasTickets
              ? _isTableView
                  ? SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: SupportTable(
                        tickets: provider.tickets,
                        onTicketTap: (ticket) {
                          _showTicketDetails(ticket);
                        },
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: provider.tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = provider.tickets[index];
                        return TicketCard(
                          ticket: ticket,
                          onTap: () => _showTicketDetails(ticket),
                        );
                      },
                    )
              : _buildEmptyState(),
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
            Icons.support_agent_outlined,
            size: 100.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 20.h),
          Text(
            "You haven't raised any tickets yet.",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton.icon(
            onPressed: _showCreateTicketDialog,
            icon: const Icon(Icons.add),
            label: const Text('Create Your First Ticket'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTicketDetails(SupportTicket ticket) {
    // TODO: Navigate to ticket details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ticket #${ticket.id} details coming soon!'),
      ),
    );
  }
}