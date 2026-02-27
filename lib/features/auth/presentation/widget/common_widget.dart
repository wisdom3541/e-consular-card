import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// App Bar
Widget buildAuthAppBar() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    height: 78.h,
    color: const Color(0xff1a6c41),
    alignment: Alignment.centerLeft,
    child: Text(
      "E-Consular Card",
      style: TextStyle(
        fontSize: 20.sp,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

// "Already have account" link
Widget buildAlreadyHaveAccount(BuildContext context, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Wrap(
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 15.sp, color: Colors.grey),
        ),
        Text(
          "Log in",
          style: TextStyle(
            color: const Color(0xff24985B),
            fontSize: 15.sp,
          ),
        ),
      ],
    ),
  );
}

// Loading dialog
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        content: SizedBox(
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 20.h),
              Text(
                "Please wait...",
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Hide loading dialog
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}

// Show error snackbar
void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ),
  );
}

// Show success snackbar
void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}

// Password validation
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  
  if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$')
      .hasMatch(value)) {
    return 'Password must include:\n'
        '- 1 uppercase letter\n'
        '- 1 number\n'
        '- 1 special character\n'
        '- 8+ characters';
  }
  
  return null;
}

// String? validateField(String? value) {

// }


// Confirm password validation
String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  
  if (value != password) {
    return 'Passwords do not match';
  }
  
  return null;
}

// Email validation
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  
  return null;
}