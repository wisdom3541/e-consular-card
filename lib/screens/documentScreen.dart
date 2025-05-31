import 'package:e_document_request/models/document/document_response.dart';
import 'package:e_document_request/providers/loggedIn/cart_provider.dart';
import 'package:e_document_request/providers/loggedIn/dashboard_provider.dart';
import 'package:e_document_request/providers/login_screen_provider.dart';
import 'package:e_document_request/screens/cardDetails.dart';
import 'package:e_document_request/screens/cartScreen.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    // var appState = Provider.of<DocumentScreenState>(context);
    var dashboardProvider = Provider.of<DashboardProvider>(context);
    var document = dashboardProvider.document;
    return SingleChildScrollView(
      child: Column(
        children: [
          homePageAppBar(icon),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Request Documents",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Here are the list of documents you can request for, Select the documents you want.",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: document.length,
                        itemBuilder: (context, index) {
                          final doc = document[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                                child: cardDesign(doc, context, index)),
                          );
                        }),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

// class DocumentScreenState extends ChangeNotifier {
// var addedToCartList = [false, false, false, false];

//   //var isItemInCart = false;
//   var itemInCartVisibility = false;
//   int numberOfItem = 0;

//   void updateAddedToCartList(int index) {
//     addedToCartList[index] = !addedToCartList[index];
//     notifyListeners();
//   }

//   void updateItemInCartVisibility() {
//     if (numberOfItem == 0) {
//       itemInCartVisibility = false;
//     } else {
//       itemInCartVisibility = true;
//     }
//   }

//   void updateNumberOfItem() {
//     numberOfItem += 1;
//   }

//   void subtractNumberOfItem() {
//     numberOfItem -= 1;
//   }
// }

Widget cardDesign(Document doc, BuildContext context, int index) {
  final cartProvider = Provider.of<CartProvider>(context);
  final isAdded = cartProvider.isInCart(doc.documentId);
  final docId = doc.documentId;

  Widget inCart = addToCartButton(context, index, docId);

  if (isAdded) {
    inCart = addedToCart(context, index, docId);
  } else {
    inCart = addToCartButton(context, index, docId);
  }

  return Card(
    elevation: 10,
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc.documentName,
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            doc.documentDescription,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardAmount(doc.documentAmount),
              cardExpires(doc.documentExpiry.toString())
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          cardDetailsAndRequest(context, inCart)
        ],
      ),
    ),
  );
}

Widget cardDetailsAndRequest(BuildContext context, Widget addToCart) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CardDetails()));
          },
          child: const Text(
            "Details",
            style: TextStyle(color: Color(0xff24985B)),
          ),
        ),
        addToCart
      ],
    ),
  );
}

Widget addToCartButton(BuildContext context, int index, String docId) {
  var cartProvider = Provider.of<CartProvider>(context);
  String token = Provider.of<LoginScreenProvider>(context).userLoggedInToken;
  return Container(
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF24985B),
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(5))),
      onPressed: () async {
        showLoadingSpinner(context);
        await cartProvider.addToCart(token, docId);
        cartProvider.toggleCartItem(docId);
        Navigator.pop(context);
        // appState.updateNumberOfItem();
        //appState.updateItemInCartVisibility();
      },
      child: const Text(
        "Add To Cart +",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget addedToCart(BuildContext context, int index, String docId) {
  var cartProvider = Provider.of<CartProvider>(context);
  String token = Provider.of<LoginScreenProvider>(context).userLoggedInToken;
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xffE9F5EF)),
        child: const Row(
          children: [
            Text(
              "Added To Cart",
              style: TextStyle(
                  color: Color(0xff24985B),
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.check_circle_outline_rounded,
              size: 20,
              color: Color(0xFF24985B),
            )
          ],
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      GestureDetector(
        onTap: () async {
          showLoadingSpinner(context);
          await cartProvider.removeFromCart(token, docId);
          cartProvider.toggleCartItem(docId);
          Navigator.pop(context);
          //  appState.subtractNumberOfItem();
          //  appState.updateItemInCartVisibility();
        },
        child: const Icon(
          Icons.delete_forever_rounded,
          fill: 1,
          size: 30,
          color: Color(0xFFD80707),
        ),
      )
    ],
  );
}

Widget cartIcon(BuildContext context) {
  var cartProvider = Provider.of<CartProvider>(context);
  var lcp = Provider.of<LoginScreenProvider>(context,listen: false);
  String token = lcp.userLoggedInToken;
  return GestureDetector(
    onTap: () async {
      showLoadingSpinner(context);
      await cartProvider.updateCartResponse(token);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CartScreen()));
    },
    child: const Row(
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
          size: 30,
        ),
        Visibility(
          visible: false, //cartProvider.itemInCartVisibility,
          child: Align(
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.circle_rounded,
              color: Colors.red,
              size: 10,
            ),
          ),
        )
      ],
    ),
  );
}
