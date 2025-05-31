import 'package:e_document_request/providers/app_provider.dart';
import 'package:e_document_request/providers/create_acccount_with_nin_provider.dart';
import 'package:e_document_request/providers/loggedIn/cart_provider.dart';
import 'package:e_document_request/providers/loggedIn/dashboard_provider.dart';
import 'package:e_document_request/providers/loggedIn/document_provider.dart';
import 'package:e_document_request/providers/login_screen_provider.dart';
import 'package:e_document_request/providers/otp_provider.dart';
import 'package:e_document_request/providers/update_nin_data_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/documentScreen.dart';
import 'package:e_document_request/screens/emptyRequestScreen.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:e_document_request/screens/payWithCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(
            create: (context) => CreateAcccountWithNinProvider()),
       
        ChangeNotifierProvider(create: (context) => PayWithCardState()),
        ChangeNotifierProvider(create: (context) => HomePageState()),
        ChangeNotifierProvider(create: (context)=> DocumentProvider()),
        ChangeNotifierProvider(create: (context)=> UpdateNinDataProvider()),
        ChangeNotifierProvider(create: (context)=> LoginScreenProvider()),
        ChangeNotifierProvider(create: (context)=> DashboardProvider()),
         ChangeNotifierProvider(create: (context) => OtpProvider()),
          ChangeNotifierProvider(create: (context)=> CartProvider()),
         

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            title: 'E-DocRequest',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const mainHolder()
            // OtpScreen(
            //                   otpType: "Enter OTP sent to your mail",
            //                   otpMessage:
            //                       "We sent an OTP to your email to verify your account",
            //                   nextPage: Enteryourdetails(),
            //                 ),
          );
        },
      ),
    );
  }
}

class mainHolder extends StatefulWidget {
  const mainHolder({super.key});

  @override
  State<mainHolder> createState() => _mainHolderState();
}

class _mainHolderState extends State<mainHolder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
       // body: EmptyRequestScreen(),
        body: CreateAccount(),
      ),
    );
  }
}
