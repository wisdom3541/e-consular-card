// import 'package:e_consular_card/providers/loggedIn/dashboard_provider.dart';
// import 'package:e_consular_card/screens/cardDetails.dart';
// import 'package:e_consular_card/screens/documentScreen.dart';
// import 'package:e_consular_card/screens/notificationScreen.dart';
// import 'package:e_consular_card/screens/paymentScreen.dart';
// import 'package:e_consular_card/screens/settings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var appState = Provider.of<HomePageState>(context);
//     var selectedIndex = appState.selectedIndex;
//     Widget icon = notificationIcon(context);

//     Widget page = HomePageContent(context, icon);
//     switch (selectedIndex) {
//       case 0:
//         icon = cartIcon(context);
//         page = DocumentScreen(icon: icon);
//         break;

//       case 1:
//         icon = notificationIcon(context);
//         page = HomePageContent(context, icon);
//         break;

//       case 2:
//         icon = notificationIcon(context);
//         page = Settings();
//         break;
//     }

//     return SafeArea(
//       child: Scaffold(
//         body: page,
//         bottomNavigationBar: NavigationBar(
//           elevation: 5,
//           indicatorColor: const Color(0xffE9F5EF),
//           destinations: bottomNavDestination,
//           selectedIndex: appState.selectedIndex,
//           onDestinationSelected: (index) {
//             appState.updateSelectedIndex(index);
//           },
//         ),
//       ),
//     );
//   }
// }

// class HomePageState extends ChangeNotifier {
//   var selectedIndex = 1;
//   var selectedFilter = 0;

//   var filter1 = [0xffE9F5EF, 0xffBBDFCC, 0xff9BD0B5];
//   var filter2 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//   var filter3 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];

//   void updateActiveFilter(String filter) {
//     if (filter == "filter1") {
//       filter1 = [0xffE9F5EF, 0xffBBDFCC, 0xff9BD0B5];
//       filter2 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//       filter3 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//     } else if (filter == "filter2") {
//       filter1 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//       filter2 = [0xffE9F5EF, 0xffBBDFCC, 0xff9BD0B5];
//       filter3 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//     } else {
//       filter1 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//       filter2 = [0xffF0F2F5, 0xffE4E7EC, 0xffD7DBE2];
//       filter3 = [0xffE9F5EF, 0xffBBDFCC, 0xff9BD0B5];
//     }
//     notifyListeners();
//   }

//   void updateSelectedIndex(int index) {
//     selectedIndex = index;
//     notifyListeners();
//   }

//   void updateSelectedFilter(int value) {
//     selectedFilter = value;
//     notifyListeners();
//   }
// }

// Widget HomePageContent(BuildContext context, Widget icon) {
//   var appState = Provider.of<HomePageState>(context);
//   var dp = Provider.of<DashboardProvider>(context);
//   var selectedFilter = appState.selectedFilter;

//   Widget filterContent = EmptyCard(context);

//   switch (selectedFilter) {
//     case 0:
//       filterContent = EmptyCard(context);
//       break;

//     case 1:
//       filterContent = EmptyCard(context);
//       break;

//     case 2:
//       filterContent = EmptyCard(context);
//       break;
//   }

//   return SingleChildScrollView(
//     child: Column(children: [
//       homePageAppBar(icon),
//       Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//                Wrap(children: [
//                 const Text(
//                   "Welcome, ",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   dp.citizenData.firstName,
//                   style: const TextStyle(
//                       color: Color(0xff24985B),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600),
//                 )
//               ]),
//               const SizedBox(
//                 height: 20,
//               ),
//               requestIdCard(),
//               const SizedBox(
//                 height: 20,
//               ),
//               filterWidgetBar(context),
//               const SizedBox(
//                 height: 20,
//               ),
//               searchBar(),
//               const SizedBox(
//                 height: 20,
//               ),
//               Align(alignment: Alignment.center, child: filterButton()),
//               const SizedBox(
//                 height: 30,
//               ),
//               filterContent,
//               const SizedBox(
//                 height: 20,
//               )
//             ],
//           ))
//     ]),
//   );
// }

// var bottomNavDestination = const [
//   NavigationDestination(
//       icon: Icon(
//         Icons.file_copy_rounded,
//         fill: 1,
//         color: Color(0xFF24985B),
//       ),
//       label: "Document"),
//   NavigationDestination(
//       icon: Icon(Icons.dashboard_customize_outlined,
//           fill: 1, color: Color(0xFF24985B)),
//       label: "Dashboard"),
 
//   NavigationDestination(
//       icon: Icon(Icons.settings, fill: 1, color: Color(0xFF24985B)),
//       label: "Settings")
// ];

// Widget requestIdCard() {
//   return Container(
//     //height: 37,'
//     padding: const EdgeInsets.all(10),
//     color: const Color(0xffE9F5EF),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "\"Identity, Simplified: Your\nNational ID Awaits\"",
//               style: TextStyle(
//                   fontSize: 15,
//                   color: Color(0xff50AD7C),
//                   fontWeight: FontWeight.w700),
//             ),
//             Text(
//               "You can request your ID easily now on our\nplatform, in less than a week have it ready to\ndownload.",
//               style: TextStyle(fontSize: 10, color: Colors.black),
//             )
//           ],
//         ),
//         Container(
//             child: Image.asset(
//           "images/cardimage.png",
//           height: 60,
//           width: 100,
//         ))
//       ],
//     ),
//   );
// }

// Widget AvailableCard(BuildContext context) {
//   return requestedCardDesign("National ID Card", context);
// }

// Widget EmptyCard(BuildContext context) {
//   var appState = Provider.of<HomePageState>(context);

//   return Container(
//     child: Column(
//       children: [
//         Align(
//           alignment: Alignment.center,
//           child: Image.asset(
//             "images/docImg.png",
//             // height: 100,
//             // width: 100,
//           ),
//         ),
//         const Text(
//           "You currently don’t have any pending or processed documents. You can request for one now",
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: Container(
//             //width: double.infinity,
//             height: 36.h,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                   backgroundColor: const Color(0xFF24985B),
//                   shape: RoundedRectangleBorder(
//                       side: BorderSide.none,
//                       borderRadius: BorderRadius.circular(5.r))),
//               onPressed: () {
//                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//                 appState.updateSelectedIndex(0);
//               },
//               child: const Text(
//                 "Request New Document",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

// Color grey = const Color(0xffF0F2F5);
// Color greyInner = const Color(0xffE4E7EC);
// Color greyBorder = const Color(0xffD7DBE2);

// Widget filterWidgetBar(BuildContext context) {
//   var appState = Provider.of<HomePageState>(context);
//   var f1 = appState.filter1;
//   var f2 = appState.filter2;
//   var f3 = appState.filter3;

//   return Container(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         filterTypes(
//             "All Requests", "0", Color(f1[0]), Color(f1[1]), Color(f1[2]), () {
//           appState.updateActiveFilter("filter1");
//           appState.updateSelectedFilter(0);
//         }),
//         filterTypes("Pending", "0", Color(f2[0]), Color(f2[1]), Color(f2[2]),
//             () {
//           appState.updateActiveFilter("filter2");
//           appState.updateSelectedFilter(1);
//         }),
//         filterTypes("Approved", "0", Color(f3[0]), Color(f3[1]), Color(f3[2]),
//             () {
//           appState.updateActiveFilter("filter3");
//           appState.updateSelectedFilter(2);
//         })
//       ],
//     ),
//   );
// }

// Widget filterTypes(String name, String number, Color background,
//     Color numberBackground, Color borderColor, Function() onTap) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       decoration: BoxDecoration(
//           color: background,
//           //shape: BoxShape.circle,
//           border: Border.all(color: borderColor, width: 1),
//           borderRadius: BorderRadius.circular(10.0)),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Wrap(
//         crossAxisAlignment: WrapCrossAlignment.center,
//         children: [
//           Text(name),
//           const SizedBox(
//             width: 5,
//           ),
//           Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: numberBackground,
//                 // borderRadius: BorderRadius.circular(10.0)
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//               child: Text(
//                 number,
//                 textAlign: TextAlign.center,
//               ))
//         ],
//       ),
//     ),
//   );
// }

// Widget searchBar() {
//   return Container(
//     width: double.infinity,
//     //color: grey,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               border: Border.all(width: 1, color: greyBorder),
//               borderRadius: BorderRadius.circular(10)),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           width: 350,
//           child: const TextField(
//             decoration: InputDecoration(
//                 border: InputBorder.none,
//                 icon: Icon(Icons.search),
//                 iconColor: Color(0xff667085),
//                 hintText: "Search"),
//           ),
//         )
//       ],
//     ),
//   );
// }

// Widget filterButton() {
//   return Container(
//     width: 350,
//     // alignment: Alignment.center,
//     child: OutlinedButton(
//       style: OutlinedButton.styleFrom(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//       onPressed: () {},
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.filter_list_rounded),
//           SizedBox(width: 10),
//           Text("Filter")
//         ],
//       ),
//     ),
//   );
// }

// Widget cardAmount(String amount) {
//   return  Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Total amount",
//         style: TextStyle(color: Color(0xffA8A8A8)),
//       ),
//       const SizedBox(
//         height: 5,
//       ),
//       Text(
//         "\$$amount",
//         style: const TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Color(0xff24985B),
//             fontSize: 20),
//       )
//     ],
//   );
// }

// Widget cardExpires(String expiryYear) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Expires After ",
//         style: TextStyle(color: Color(0xffA8A8A8)),
//       ),
//       const SizedBox(
//         height: 5,
//       ),
//       Text(
//         "$expiryYear Months",
//         style: const TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Color(0xff1470F9),
//             fontSize: 20),
//       )
//     ],
//   );
// }

// Widget requestedCardDesign(String cardName, BuildContext context) {
//   return Card(
//     elevation: 10,
//     child: Container(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             cardName,
//             style: const TextStyle(
//                 fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           const Text(
//             "Nike operates retail stores worldwide,including Nike-branded retail outlets,factory stores, and concept stores....",
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [status("pending"), requestedDate()],
//           ),
//           const SizedBox(
//             height: 20,
//           ),

//           Align(
//             alignment: Alignment.center,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const CardDetails()));
//               },
//               child: const Text(
//                 "Details",
//                 style: TextStyle(color: Color(0xff24985B)),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           )
//           // cardDetailsAndRequest(context, buttonText)
//         ],
//       ),
//     ),
//   );
// }

// Widget status(String status) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Status",
//         style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: const Color(0xffFFFAEB)),
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             status,
//             style: const TextStyle(
//               color: Colors.deepOrange,
//             ),
//           ))
//     ],
//   );
// }

// Widget requestedDate() {
//   return const Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Requested On ",
//         style: TextStyle(color: Color(0xffA8A8A8)),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Text(
//         "25, Dec 2023",
//         style: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Color(0xff1470F9),
//             fontSize: 20),
//       )
//     ],
//   );
// }

// Widget homePageAppBar(Widget appBarIcon) {
//   return Container(
//     padding: const EdgeInsets.all(15.0),
//     color: const Color(0xff1a6c41),
//     // color: const Color.fro(26, 108, 65, 100),
//     //Color.fromRGBO(20, 84, 50, 100),
//     alignment: Alignment.centerLeft,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           "IDOCREQUEST",
//           style: TextStyle(
//               fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800),
//         ),
//         appBarIcon
//       ],
//     ),
//   );
// }

// Widget notificationIcon(
//   BuildContext context,
// ) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => const NotificationScreen()));
//     },
//     child: const Icon(
//       Icons.notifications_none_rounded,
//       color: Colors.white,
//       size: 30,
//     ),
//   );
// }