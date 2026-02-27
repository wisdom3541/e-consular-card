// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../providers/support_provider.dart';
// import '../../data/models/support_ticket_models.dart';

// class TicketDetailsPage extends StatefulWidget {
//   final SupportTicket ticket;

//   const TicketDetailsPage({
//     Key? key,
//     required this.ticket,
//   }) : super(key: key);

//   @override
//   State<TicketDetailsPage> createState() => _TicketDetailsPageState();
// }

// class _TicketDetailsPageState extends State<TicketDetailsPage> {
//   final _replyController = TextEditingController();
//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     // Load ticket details with replies
//     Future.microtask(() {
//       context.read<SupportProvider>().loadTicketDetails(
//             ticketId: widget.ticket.id,
//           );
//     });

//     // Setup scroll listener for pagination
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       // Load more replies
//       final provider = context.read<SupportProvider>();
//       if (provider.hasMoreReplies && !provider.isLoadingReplies) {
//         provider.loadMoreReplies(widget.ticket.id);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _replyController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSendReply() async {
//     if (_replyController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter a message'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     final provider = context.read<SupportProvider>();

//     final success = await provider.replyToTicket(
//       ticketId: widget.ticket.id,
//       message: _replyController.text.trim(),
//     );

//     if (success) {
//       _replyController.clear();
      
//       // Scroll to bottom to show new reply
//       Future.delayed(const Duration(milliseconds: 300), () {
//         if (_scrollController.hasClients) {
//           _scrollController.animateTo(
//             _scrollController.position.maxScrollExtent,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//           );
//         }
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Reply sent successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(provider.errorMessage ?? 'Failed to send reply'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<SupportProvider>();

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//    //   appBar: const CommonAppBar(title: "Ticket Details"),
//       body: Column(
//         children: [
//           // Ticket Info Card
//           _buildTicketInfoCard(),

//           // Replies List
//           Expanded(
//             child: provider.isLoadingReplies && provider.replies.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : _buildRepliesList(provider),
//           ),

//           // Reply Input
//           _buildReplyInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTicketInfoCard() {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Status and Priority
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                 decoration: BoxDecoration(
//                   color: widget.ticket.statusBackgroundColor,
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   widget.ticket.displayStatus,
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     fontWeight: FontWeight.w700,
//                     color: widget.ticket.statusColor,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8.w),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                 decoration: BoxDecoration(
//                   color: widget.ticket.priorityColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   widget.ticket.displayPriority,
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     fontWeight: FontWeight.w700,
//                     color: widget.ticket.priorityColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 12.h),

//           // Subject
//           Text(
//             widget.ticket.subject,
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),

//           SizedBox(height: 12.h),

//           // Category and Date
//           Row(
//             children: [
//               Icon(Icons.category_outlined, size: 16.sp, color: Colors.grey),
//               SizedBox(width: 4.w),
//               Text(
//                 widget.ticket.category,
//                 style: TextStyle(
//                   fontSize: 13.sp,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
//               SizedBox(width: 4.w),
//               Text(
//                 DateFormat('dd MMM yyyy').format(
//                   DateTime.parse(widget.ticket.createdAt),
//                 ),
//                 style: TextStyle(
//                   fontSize: 13.sp,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 12.h),

//           // Message
//           Container(
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Text(
//               widget.ticket.message,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 height: 1.5,
//               ),
//             ),
//           ),

//           // File attachment if any
//           if (widget.ticket.file != null) ...[
//             SizedBox(height: 12.h),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.attach_file, size: 20.sp, color: Colors.blue),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     child: Text(
//                       'Attachment: ${widget.ticket.file}',
//                       style: TextStyle(
//                         fontSize: 13.sp,
//                         color: Colors.blue.shade900,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildRepliesList(SupportProvider provider) {
//     if (provider.replies.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.chat_bubble_outline,
//               size: 64.sp,
//               color: Colors.grey.shade300,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'No replies yet',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Start the conversation',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey.shade500,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       controller: _scrollController,
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       itemCount: provider.replies.length +
//           (provider.isLoadingReplies && provider.replies.isNotEmpty ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index == provider.replies.length) {
//           // Loading indicator at the end
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.all(16.w),
//               child: const CircularProgressIndicator(),
//             ),
//           );
//         }

//         final reply = provider.replies[index];
//         final isUser = reply.isFromUser;

//         return Align(
//           alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             margin: EdgeInsets.only(bottom: 12.h),
//             constraints: BoxConstraints(maxWidth: 280.w),
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               color: isUser ? AppColors.primary : Colors.white,
//               borderRadius: BorderRadius.circular(12.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 5,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Sender name
//                 Text(
//                   reply.senderName,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: isUser ? Colors.white.withOpacity(0.9) : Colors.grey.shade700,
//                   ),
//                 ),
//                 SizedBox(height: 6.h),

//                 // Message
//                 Text(
//                   reply.message,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: isUser ? Colors.white : Colors.black87,
//                     height: 1.4,
//                   ),
//                 ),

//                 SizedBox(height: 6.h),

//                 // Time
//                 Text(
//                   DateFormat('hh:mm a').format(
//                     DateTime.parse(reply.createdAt),
//                   ),
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     color: isUser ? Colors.white.withOpacity(0.7) : Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildReplyInput() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _replyController,
//                 maxLines: null,
//                 decoration: InputDecoration(
//                   hintText: 'Type your reply...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(24.r),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 16.w,
//                     vertical: 12.h,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//             CircleAvatar(
//               radius: 24.r,
//               backgroundColor: AppColors.primary,
//               child: IconButton(
//                 icon: const Icon(Icons.send, color: Colors.white),
//                 onPressed: _handleSendReply,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:e_consular_card/core/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/support_provider.dart';
import '../../data/models/support_ticket_models.dart';

class TicketDetailsPage extends StatefulWidget {
  final SupportTicket ticket;

  const TicketDetailsPage({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  final _replyController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load ticket details with replies
    Future.microtask(() {
      context.read<SupportProvider>().loadTicketDetails( ticketId: widget.ticket.id);
    });
  }

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSendReply() async {
    if (_replyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<SupportProvider>();

    final success = await provider.replyToTicket(
      ticketId: widget.ticket.id,
      message: _replyController.text.trim(),
    );

    if (success) {
      _replyController.clear();
      
      // Scroll to bottom to show new reply
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reply sent successfully'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 300),
        ),
      );
    } else {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Failed to send reply'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SupportProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
     // appBar: const CommonAppBar(title: "Ticket Details"),
      body: provider.isLoadingReplies && provider.selectedTicketData?.id != widget.ticket.id
        ? const Center(child: CircularProgressIndicator()) // LOADING STATE
        : Column(
        children: [
          SizedBox(height: 30.h),
          // Ticket Info Card - Use data from provider or widget
          _buildTicketInfoCard(provider.selectedTicketData ?? _convertToTicketData()),

          // Replies List
          Expanded(
            child: provider.isLoadingReplies && provider.replies.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null && provider.replies.isEmpty
                    ? _buildErrorState(provider.errorMessage!)
                    : _buildRepliesList(provider),
          ),

          // Reply Input
          _buildReplyInput(),
        ],
      ),
    );
  }

  // Convert SupportTicket to SingleTicketData for display
  SingleTicketData _convertToTicketData() {
    return SingleTicketData(
      id: widget.ticket.id,
      userId: widget.ticket.userId,
      category: widget.ticket.category,
      priority: widget.ticket.priority,
      subject: widget.ticket.subject,
      message: widget.ticket.message,
      file: widget.ticket.file,
      status: widget.ticket.status,
      createdAt: widget.ticket.createdAt,
      updatedAt: widget.ticket.updatedAt,
      replies: [],
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            error,
            style: TextStyle(fontSize: 14.sp, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {
              context.read<SupportProvider>().loadTicketDetails(ticketId: widget.ticket.id);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfoCard(SingleTicketData ticketData) {
   
   
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status and Priority
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ticketData.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  ticketData.displayStatus,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: ticketData.statusColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ticketData.priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  ticketData.displayPriority,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: ticketData.priorityColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Subject
          Text(
            ticketData.subject,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 12.h),

          // Category and Date
          Row(
            children: [
              Icon(Icons.category_outlined, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                ticketData.category,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
               DateHelper.formatDate(ticketData.createdAt),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Message
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              ticketData.message,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ),

          // File attachment if any
          if (ticketData.file != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_file, size: 20.sp, color: Colors.blue),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Attachment: ${ticketData.file}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.blue.shade900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRepliesList(SupportProvider provider) {
    if (provider.replies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64.sp,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            Text(
              'No replies yet',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Start the conversation',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: provider.replies.length,
      itemBuilder: (context, index) {
        final reply = provider.replies[index];
        final isUser = reply.isFromUser;

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            constraints: BoxConstraints(maxWidth: 280.w),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isUser ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender name
                Text(
                  reply.senderName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isUser ? Colors.white.withOpacity(0.9) : Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 6.h),

                // Message
                Text(
                  reply.message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isUser ? Colors.white : Colors.black87,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 6.h),

                // Time
                Text(
                  DateHelper.formatDate(reply.createdAt),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isUser ? Colors.white.withOpacity(0.7) : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReplyInput() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _replyController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type your reply...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _handleSendReply,
              ),
            ),
          ],
        ),
      ),
    );
  }
}