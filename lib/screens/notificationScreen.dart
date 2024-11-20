import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(28.h),
          child: Column(
            children: [
              topPanel(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return notificationTemplate(
                          notificationList[index].notificationInfo,
                          notificationList[index].buttonText,
                          notificationList[index].date);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationTemplateList {
  final String notificationInfo;
  final String buttonText;
  final String date;

  NotificationTemplateList(
      {required this.notificationInfo,
      required this.buttonText,
      required this.date});
}

List<NotificationTemplateList> notificationList = [
  NotificationTemplateList(
      notificationInfo:
          "Your documents are ready for download. You can check your main dashboard or your documents page to view and download them",
      buttonText: "View Documents",
      date: "Yesterday at 11:42 PM"),
  NotificationTemplateList(
      notificationInfo:
          "Your documents are ready for download. You can check your main dashboard or your documents page to view and download them",
      buttonText: "View Documents",
      date: "Today at 01:30 PM"),
  NotificationTemplateList(
      notificationInfo:
          "You recently paid for some document(s). You can view your receipt",
      buttonText: "View Receipt",
      date: "Today at 01:30 PM"),
  NotificationTemplateList(
      notificationInfo:
          "You recently paid for some document(s). You can view your receipt",
      buttonText: "View Receipt",
      date: "Today at 20:30 PM"),
  NotificationTemplateList(
      notificationInfo:
          "Your documents are ready for download. You can check your main dashboard or your documents page to view and download them",
      buttonText: "View Documents",
      date: "Yesterday at 11:42 PM"),
  NotificationTemplateList(
      notificationInfo:
          "Your documents are ready for download. You can check your main dashboard or your documents page to view and download them",
      buttonText: "View Documents",
      date: "Today at 01:30 PM"),
  NotificationTemplateList(
      notificationInfo:
          "You recently paid for some document(s). You can view your receipt",
      buttonText: "View Receipt",
      date: "Today at 01:30 PM"),
  NotificationTemplateList(
      notificationInfo:
          "You recently paid for some document(s). You can view your receipt",
      buttonText: "View Receipt",
      date: "Today at 20:30 PM"),
];

Widget topPanel() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Notifications",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        filterWidget()
      ],
    ),
  );
}

Widget filterWidget() {
  return Row(
    children: [
      const Text("Filter"),
      const SizedBox(
        width: 5,
      ),
      Icon(
        Icons.filter_list_rounded,
        size: 20,
      )
    ],
  );
}

Widget notificationTemplate(
    String notificationInfo, String buttonText, String date) {
  return Card(
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notificationInfo,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF24985B),
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.r))),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              child: Text(
                buttonText,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ),
  );
}
