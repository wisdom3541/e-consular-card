// import 'dart:typed_data';

// import 'package:e_consular_card/providers/loggedIn/dashboard_provider.dart';
// import 'package:e_consular_card/screens/loginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';

// class Settings extends StatelessWidget {
//   Settings({super.key});

//   //final userCtrl = Get.find<UserDataController>();

//   @override
//   Widget build(BuildContext context) {
//     var dp = Provider.of<DashboardProvider>(context);
//     Uint8List? image;
//     if (dp.passportImage != null) {
//       image = dp.passportImage;
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 15.w),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20.h,
//             ),
//             settingsAppBar(),
//             SizedBox(
//               height: 21.h,
//             ),
//             Center(
//               child: ClipOval(
//                 child: 
//                 dp.passportImage != null?
//                 Image.memory(
//                   dp.passportImage!,
//                   width: 120,
//                   height: 120,
//                   fit: BoxFit.cover,
//                 ): Image.asset(
//                    'images/profile_img.png',
//                   width: 120,
//                   height: 120,
//                   fit: BoxFit.cover,
//                 ),

               
//               ),
//             ),
//             SizedBox(
//               height: 13.h,
//             ),
//             Text(
//               "${dp.citizenData.firstName} ${dp.citizenData.lastName}",
//               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
//             ),
//             Text(
//               dp.citizenData.emailAddress,
//               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
//             ),
//             SizedBox(
//               height: 37.h,
//             ),
//             SettingsList()
//           ],
//         ),
//       ),
//     );

//     // return dp.passportImage != null
//     //     ? Center(
//     //       child: Image.memory(
//     //           dp.passportImage!,
//     //           width: 300,
//     //           height: 300,
//     //           fit: BoxFit.cover,
//     //         ),
//     //     )
//     //     : const Text("No passport image available");
//   }
// }

// class SettingsList extends StatefulWidget {
//   const SettingsList({Key? key}) : super(key: key);

//   @override
//   State<SettingsList> createState() => _SettingsListState();
// }

// class _SettingsListState extends State<SettingsList> {
//   bool notificationsEnabled = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Notifications with toggle
//         _buildSwitchTile(
//           icon: Icons.notifications_none,
//           title: "Notifications",
//           subtitle: "Enable push notifications",
//           value: notificationsEnabled,
//           onChanged: (val) => setState(() => notificationsEnabled = val),
//         ),

//         const Divider(height: 0),

//         // Request History
//         _buildListTile(
//           icon: Icons.history,
//           title: "Request History",
//           subtitle: "Redirects to full archive",
//           onTap: () => print("Navigate to Request History"),
//         ),

//         const Divider(height: 0),

//         // Payment Method
//         _buildListTile(
//           icon: Icons.credit_card,
//           title: "Payment method",
//           subtitle: "Add new card",
//           onTap: () => print("Navigate to Payment Method"),
//         ),

//         const Divider(height: 0),

//         // Contact Support
//         _buildListTile(
//           icon: Icons.help_outline,
//           title: "Contact Support",
//           subtitle: "Opens chat or support form",
//           onTap: () => print("Open Support"),
//         ),

//         SizedBox(
//           height: 68.h,
//         ),
//         logoutButton(() {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const LoginScreen()),
//             (Route<dynamic> route) => false, // Remove all previous routes
//           );
//         })
//       ],
//     );
//   }

//   Widget _buildSwitchTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.black87),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//       subtitle: Text(subtitle),
//       trailing: Switch(
//         value: value,
//         onChanged: onChanged,
//         activeColor: Colors.green,
//       ),
//     );
//   }

//   Widget _buildListTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.black87),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//       subtitle: Text(subtitle),
//       trailing: const Icon(Icons.chevron_right),
//       onTap: onTap,
//     );
//   }
// }

// Widget settingsAppBar() {
//   return SizedBox(
//     height: 44.h,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Icon(
//           Icons.arrow_back_ios_rounded,
//           size: 24.sp,
//           color: Colors.black,
//         ),
//         Text(
//           "Settings",
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 14.sp,
//           ),
//         ),
//         Icon(
//           Icons.notifications_active_outlined,
//           size: 24.sp,
//           color: Colors.black,
//         ),
//       ],
//     ),
//   );
// }

// Widget logoutButton(VoidCallback onTap) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(Icons.logout, color: Colors.red, size: 24.sp),
//         const SizedBox(width: 8),
//         Text(
//           "Logout",
//           style: TextStyle(
//             fontSize: 16.sp,
//             color: Colors.black87,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     ),
//   );
// }
