import 'package:e_document_request/screens/cardDetails.dart';
import 'package:e_document_request/screens/cartScreen.dart';
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
    var appState = Provider.of<DocumentScreenState>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          homePageAppBar(icon),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Request Documents",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Here are the list of documents you can request for, Select the documents you want.",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                                child: cardDesign(
                                    "Activation Licensee",
                                    context,
                                    appState.addedToCartList[index],
                                    index)),
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

class DocumentScreenState extends ChangeNotifier {
  var addedToCartList = [false, false, false, false];

  //var isItemInCart = false;
  var itemInCartVisibility = false;
  int numberOfItem = 0;

  void updateAddedToCartList(int index) {
    addedToCartList[index] = !addedToCartList[index];
    notifyListeners();
  }

  void updateItemInCartVisibility() {
    if (numberOfItem == 0) {
      itemInCartVisibility = false;
    } else {
      itemInCartVisibility = true;
    }
  }

  void updateNumberOfItem() {
    numberOfItem += 1;
  }

  void subtractNumberOfItem() {
    numberOfItem -= 1;
  }
}

Widget cardDesign(
    String cardName, BuildContext context, bool isInCart, int index) {
  Widget inCart = addToCartButton(context, index);
  if (isInCart) {
    inCart = addedToCart(context, index);
  } else {
    inCart = addToCartButton(context, index);
  }

  return Card(
    elevation: 10,
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardName,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Nike operates retail stores worldwide,including Nike-branded retail outlets,factory stores, and concept stores....",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [cardAmount(), cardExpires("6 Months")],
          ),
          SizedBox(
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
                MaterialPageRoute(builder: (context) => CardDetails()));
          },
          child: Text(
            "Details",
            style: TextStyle(color: Color(0xff24985B)),
          ),
        ),
        addToCart
      ],
    ),
  );
}

Widget addToCartButton(BuildContext context, int index) {
  var appState = Provider.of<DocumentScreenState>(context);
  return Container(
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF24985B),
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(5))),
      onPressed: () {
        appState.updateAddedToCartList(index);
        appState.updateNumberOfItem();
        appState.updateItemInCartVisibility();
      },
      child: Text(
        "Add To Cart +",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget addedToCart(BuildContext context, int index) {
  var appState = Provider.of<DocumentScreenState>(context);
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0xffE9F5EF)),
        child: Row(
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
      SizedBox(
        width: 5,
      ),
      GestureDetector(
        onTap: () {
          appState.updateAddedToCartList(index);
          appState.subtractNumberOfItem();
          appState.updateItemInCartVisibility();
        },
        child: Icon(
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
  var appState = Provider.of<DocumentScreenState>(context);
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
    },
    child: Row(
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
          size: 30,
        ),
        Visibility(
          visible: appState.itemInCartVisibility,
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
