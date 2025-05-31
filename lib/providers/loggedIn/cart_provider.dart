import 'package:e_document_request/core/cart/data/add_to_cart_response.dart';
import 'package:e_document_request/core/cart/data/cart_response.dart';
import 'package:e_document_request/core/cart/data/remove_from_cart_response.dart';
import 'package:e_document_request/core/cart/domain/add_to_cart_api.dart';
import 'package:e_document_request/core/cart/domain/all_cart_api.dart';
import 'package:e_document_request/core/cart/domain/remove_from_cart_api.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{

late CartResponse cartResponse;
late List<CartItem> cartItems;
late AddToCartResponse addToCartResponse;
late RemoveFromCartResponse removeFromCartResponse;
late ClearCartResponse clearCartResponse;


 final List<String> itemsInCart = []; // or CartItem objects

 // List<String> get cartItems => _cartItems;

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


Future<void> updateCartResponse(String token)async {
var response = await AllCartApi().getAllCartItems(token);
cartResponse = response!;
if(cartResponse.success){
cartItems = cartResponse.items;

// for (var doc in cartItems) {
//   itemsInCart.add(doc.documentID);
// }


print(itemsInCart.length);}
notifyListeners();

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
    print("removeFromCart failed: response is null");
    return;
  }
  clearCartResponse = response;
  if(removeFromCartResponse.success){

  }
  notifyListeners();

}

}