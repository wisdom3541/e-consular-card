import 'package:e_document_request/core/cart/data/add_to_cart_response.dart';
import 'package:e_document_request/core/cart/data/cart_response.dart';
import 'package:e_document_request/core/cart/data/remove_from_cart_response.dart';
import 'package:e_document_request/core/cart/domain/add_to_cart_api.dart';
import 'package:e_document_request/core/cart/domain/all_cart_api.dart';
import 'package:e_document_request/core/cart/domain/remove_from_cart_api.dart';
import 'package:e_document_request/core/verify_payment_api.dart';
import 'package:e_document_request/models/payment_verification_response.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{

late CartResponse cartResponse;
late List<CartItem> cartItems;
late AddToCartResponse addToCartResponse;
late RemoveFromCartResponse removeFromCartResponse;
late ClearCartResponse clearCartResponse;
late PaymentVerificationResponse paymentVerificationResponse;


 List<String> itemsInCart = []; // or CartItem objects

 // List<String> get cartItems => _cartItems;

 void emptyCart(){
  print("cartItems before clear:: ${cartItems.first.documentID}");
  print("itemsIncaart before clear:: ${itemsInCart.last}");
  cartItems.clear();
  itemsInCart.clear();
 }

  bool isInCart(String documentID) {
    return itemsInCart.contains(documentID);
  }

  void toggleCartItem(String documentID) {
    if (itemsInCart.contains(documentID)) {
      itemsInCart.remove(documentID);
    } else {
      itemsInCart.add(documentID);
    }
    notifyListeners();
  }


//get all items in cart
Future<void> updateCartResponse(String token)async {

try {
    var response = await AllCartApi().getAllCartItems(token);
    if (response == null) {
      // Handle null case defensively
      cartItems = [];
      notifyListeners();
      return;
    }

    cartResponse = response;

    // Handle based on backend pattern
    if (cartResponse.success && cartResponse.items != null && cartResponse.items!.isNotEmpty) {
      cartItems = cartResponse.items!;
      itemsInCart = cartItems.map((e) => e.documentID).toList();
    } else {
      // Empty cart case
      cartItems = [];
      itemsInCart = [];
    }

    notifyListeners();
  } catch (e) {
    print("Cart update failed: $e");
    // Optionally show a user-friendly message
  }

}


Future<void> addToCart(String token, String docId) async{
  var response = await AddToCartApi().addToCart(token, docId);

  if (response == null) {
    print("removeFromCart failed: response is null");
    return;
  }
  addToCartResponse = response;
  if(addToCartResponse.success){

  }
  notifyListeners();
}


Future<void> removeFromCart(String token, String docId) async {
  var response = await RemoveFromCartApi().removeFromCart(token, docId);

  if (response == null) {
    print("removeFromCart failed: response is null");
    return;
  }
  removeFromCartResponse = response;

  if (removeFromCartResponse.success) {
    // Handle success if needed
  }

  notifyListeners();
}


Future<void> clearCart(String token) async{
  var response = await AllCartApi().clearCart(token);
  if (response == null) {
    print("clearCart failed: response is null");
    return;
  }
  clearCartResponse = response;
  if(clearCartResponse.success){
    print(clearCartResponse.message);

  }
  notifyListeners();
}

Future<void> verifyPayment(String token, String reference, String order_id)async {
  var response = await VerifyPaymentApi().verifyOrderPayment(token,reference, order_id);

   if (response == null) {
   // print("removeFromCart failed: response is null");
    return;
  }
  paymentVerificationResponse = response;
  if(paymentVerificationResponse.success){
    print(paymentVerificationResponse.message);
    print(paymentVerificationResponse.transactionId);

  }
  notifyListeners();
}


}
