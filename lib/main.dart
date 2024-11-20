import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/documentScreen.dart';
import 'package:e_document_request/screens/emptyRequestScreen.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:e_document_request/screens/idCardRequestScreen.dart';
import 'package:e_document_request/screens/loginScreen.dart';
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
        ChangeNotifierProvider(
            create: (context) => CreateAccountWithNINAppState()),
        ChangeNotifierProvider(create: (context) => OtpScreenState()),
        ChangeNotifierProvider(create: (context) => PayWithCardState()),
        ChangeNotifierProvider(create: (context) => HomePageState()),
        ChangeNotifierProvider(create: (context)=> DocumentScreenState())
      ],
      child: ScreenUtilInit(
        designSize: const Size(470, 830),
        builder: (context, child) {
          return MaterialApp(
            title: 'E-DocRequest',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const mainHolder(),
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
