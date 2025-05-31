import 'package:e_document_request/providers/loggedIn/cart_provider.dart';
import 'package:e_document_request/providers/loggedIn/dashboard_provider.dart';
import 'package:e_document_request/providers/login_screen_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/forgotPassword.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

typedef ValidatorFunction = String? Function(String? input);
String email = "";
String password = "";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBar(),
              SizedBox(
                height: 50.h,
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                     Text(
                      "Enter your credentials",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    LoginForm(),
                    SizedBox(
                      height: 30,
                    ),
                    createAnAccount(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

      var loginScreenProvider = Provider.of<LoginScreenProvider>(context, listen: false);
      var dashboardProvider = Provider.of<DashboardProvider>(context,listen: false);
      var cartProvider = Provider.of<CartProvider>(context,listen: false);
 
      // var loginProvider = Provider.of<LoginScreenProvider>(context,listen: false);
 

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            emailTextFieldForForm("Email*", "Enter your email", "Required",loginScreenProvider.emailController),
            const SizedBox(
              height: 20,
            ),
            passwordTextField("Password*", "Create a password",loginScreenProvider.passwordController),
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                  },
                    child: const Text(
                  "Recover Password?",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff48A876)),
                ))),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                     if (_formKey.currentState?.validate() == true) {
                  // Save the form values
                  _formKey.currentState?.save();
                  showLoadingSpinner(context);
                  await loginScreenProvider.login(email,password);
                  final userToken = loginScreenProvider.userLoggedInToken;
                  await dashboardProvider.getAllDashboardData(userToken);
                  await cartProvider.updateCartResponse(userToken);
                  Navigator.pop(context);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Enteryourdetails2()));

                //  You can display a success message using a Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged IN successfully!')),
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                   }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xff24985B),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    )),
                child: const Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget createAnAccount(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateAccount()));
      },
      child: const Wrap(
        children: [
          Text("Don't have an account? ",
              style: TextStyle(fontSize: 15.0, color: Colors.grey)),
          Text(
            "Create an account",
            style: TextStyle(color: Color(0xff48A876), fontSize: 15.0),
          )
        ],
      ),
    ),
  );
}


Widget emailTextFieldForForm(String titleText, String hintText, String errorMessageText , TextEditingController controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(titleText),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        // keyboardType: TextInputType.emailAddress,
        validator: (value) {
              // if (value == null || value.isEmpty) {
              //   return 'Please enter your email';
              // } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              //   return 'Please enter a valid email';
              // }
              // return null;
            },
        onSaved: (value) {
          email = value ?? '';
        },
      ),
    ],
  );
}

String? validateEmail(String? email, {bool allowTopLevelDomain = false}) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }

  final regex = allowTopLevelDomain
      ? RegExp(r'^[a-zA-Z0-9.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
      : RegExp(r'^[a-zA-Z0-9.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$');

  if (!regex.hasMatch(email)) {
    return 'Enter a valid email address';
  }

  return null; // Return null if valid
}


Widget passwordTextField(String title, String hint,
    TextEditingController controller,) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 14.sp)),
      SizedBox(height: 10.h),
      TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
        ),
        validator: (value){
  //         if (value == null ||
  //     !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$')
  //         .hasMatch(value)) {
  //   return 'Password must include:\n- 1 uppercase letter\n- 1 number\n- 1 special character\n- 8+ characters';
  // }
  return null;
        },
          onSaved: (value) => password = value ?? '',
      ),
    ],
  );
}
