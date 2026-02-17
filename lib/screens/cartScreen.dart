// import 'package:e_consular_card/providers/loggedIn/cart_provider.dart';
// import 'package:e_consular_card/providers/login_screen_provider.dart';
// import 'package:e_consular_card/screens/cartPayWithCard.dart';
// import 'package:e_consular_card/screens/paymentSucessful.dart';
// import 'package:e_consular_card/screens/paystack_payment_popup.dart';
// import 'package:e_consular_card/screens/widgets/no_item_in_cart_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var cartProvider = Provider.of<CartProvider>(context);
//     var cartItems = cartProvider.cartItems;
//     String token = Provider.of<LoginScreenProvider>(context).userLoggedInToken;

//     return SafeArea(
//         child: SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           // Wrap the full body in scroll view
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 28.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),
//                 onScreenBackButton(),
//                 const SizedBox(height: 50),
//                 const Text(
//                   "Items in Cart",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Here are the list of documents in your cart. Proceed to Pay",
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 const SizedBox(height: 20),

//                 // Cart Items Section
//                 cartItems.isEmpty
//                     ? const Center(child: NoItemInCart())
//                     : ListView.builder(
//                         itemCount: cartItems.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           final item = cartItems[index];
//                           // final amount  = 0 + item.documentAmount;
//                           print(item.documentAmount);
//                           return Column(
//                             children: [
//                               itemInCart(
//                                   item.documentName, item.documentAmount),
//                               const SizedBox(height: 20),
//                             ],
//                           );
//                         },
//                       ),

//                 const SizedBox(height: 50),
//                 cartItems.isEmpty ? SizedBox.shrink() : cartSummary(cartProvider.totalAmount),
//                 const SizedBox(height: 20),
//                 cartItems.isEmpty ? SizedBox.shrink() : cartTotal(cartProvider.totalAmount),
//                 const SizedBox(height: 20),
//                 cartItems.isEmpty
//                     ? SizedBox.shrink()
//                     : proceedButton(context, token),
//                 const SizedBox(height: 30), // bottom spacing
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }

// Widget onScreenBackButton() {
//   return Row(
//     children: [
//       Icon(
//         Icons.arrow_back_rounded,
//         color: Color(0xFF24985B),
//         size: 20,
//       ),
//       SizedBox(
//         width: 10,
//       ),
//       Text(
//         "Back",
//         style: TextStyle(color: Color(0xFF24985B), fontSize: 20),
//       )
//     ],
//   );
// }

// Widget itemInCart(String title, String price) {
//   return Container(
//     padding: const EdgeInsets.all(15),
//     decoration: BoxDecoration(
//         border: Border.all(width: 0.5, color: Colors.grey),
//         borderRadius: BorderRadius.circular(5)),
//     child: Row(
//       children: [
//         Expanded(
//             child: Text(
//           title,
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         )),
//         Text(
//           "₦$price",
//           style: TextStyle(
//               color: Color(0xFF24985B),
//               fontWeight: FontWeight.w600,
//               fontSize: 15),
//         )
//       ],
//     ),
//   );
// }

// Widget cartSummary(int finalAmount) {
//   return Container(
//     padding: const EdgeInsets.all(15),
//     decoration: BoxDecoration(
//         border: Border.all(width: 0.5, color: Colors.grey),
//         borderRadius: BorderRadius.circular(5)),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Cart Summary",
//           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         const Divider(
//           height: 1,
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         cartSummaryContent("Subtotal", finalAmount.toString()),
//         const SizedBox(
//           height: 30,
//         ),
//         cartSummaryContent("Delivery Fee", "0")
//       ],
//     ),
//   );
// }

// Widget cartSummaryContent(String title, String price) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         title,
//         style: TextStyle(color: Color(0xff9CA3B9), fontSize: 18),
//       ),
//       Text(
//         "₦$price",
//         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//       ),
//     ],
//   );
// }

// Widget cartTotal(int price) {
//   return Container(
//     padding: EdgeInsets.all(15),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5),
//       color: Color(0xffE9F5EF),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Total",
//           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//         ),
//         Text(
//           "₦$price",
//           style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 25,
//               color: Color(0xFF24985B)),
//         )
//       ],
//     ),
//   );
// }

// Widget proceedButton(BuildContext context, String token) {
//   var cp = Provider.of<CartProvider>(context);

//   return Container(
//     width: double.infinity,
//     height: 56.h,
//     child: OutlinedButton(
//       style: OutlinedButton.styleFrom(
//           backgroundColor: Color(0xFF24985B),
//           shape: RoundedRectangleBorder(
//               side: BorderSide.none, borderRadius: BorderRadius.circular(5.r))),
//       onPressed: () async {
//         var result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaystackPaymentPopup(amount: cp.totalAmount,),
//           ),
//         );

//         if (result != null) {
//           if (result["status"] == "success") {
//             cp.emptyCart();

//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => PaymentSucessful()));
//           } else if (result["status"] == "cancelled") {
//             // Handle cancellation
//             showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                       title: Text("Cancelled"),
//                       content: Text(result["message"]),
//                     ));
//           } else {
//             // Handle error
//             showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                       title: Text("Error"),
//                       content: Text(result["message"]),
//                     ));
//           }
//         }
//       },
//       child: Text(
//         "Proceed to Pay",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
//       ),
//     ),
//   );
// }
