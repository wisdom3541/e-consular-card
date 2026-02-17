import 'package:e_consular_card/features/auth/presentation/screens/nin_verification_page.dart';
import 'package:e_consular_card/features/auth/presentation/screens/register_with_nin_page.dart';
import 'package:e_consular_card/features/auth/presentation/screens/register_without_nin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
         //   _buildAppBar(),

         SizedBox(height: 140.h),
                _buildTitle(),
                SizedBox(height: 15.h),
                _buildSubtitle(),
            Column(
             // crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(height: 35.h),
                _buildRegistrationButtons(context),
                SizedBox(height: 50.h),
                _buildAlreadyHaveAccount(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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

  Widget _buildTitle() {
    return Text(
      "Welcome to E-Consular Card\nCreate an account",
      style: TextStyle(
        fontSize: 25.sp,
        color: Colors.black,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        "Get your account ready to get any confidential document you need to.",
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.grey,
          fontFamily: "Roboto",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRegistrationButtons(BuildContext context) {
    // Get the provider (but don't listen to changes yet)
    final authProvider = context.read<AuthProvider>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          // NIN Registration Button
          _RegistrationButton(
            text: "Register with your NIN,\nRequest for a card quicker",
            backgroundColor: const Color(0xff24985B),
            textColor: Colors.white,
            iconColor: Colors.white,
            onPressed: () {
              authProvider.setNinRegistrationType(true);

              // Simulate NIN verification (in real app, this comes from verification screen)
              authProvider.setPrefilledNin('12345678901');

               // Navigate to NIN verification page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NinVerificationPage(),
      ),
    );
            },
          ),
          SizedBox(height: 27.h),

          // Manual Registration Button
          // Manual Registration Button
          _RegistrationButton(
            text: "Manual Registration, Card request may take longer.",
            backgroundColor: const Color(0xffE9F5EF),
            textColor: Colors.grey,
            iconColor: Colors.black,
            onPressed: () {
              authProvider.setNinRegistrationType(false);

              // Navigate to manual registration screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterWithoutNinPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlreadyHaveAccount(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to login screen
        _showComingSoonDialog(context, "Login");
      },
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

  // Temporary dialog until we build other screens
  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$feature"),
        content: Text(
            "This screen will be built next!\n\nFor now, the provider state has been updated."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

// Separate widget for registration button (cleaner code)
class _RegistrationButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const _RegistrationButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 110.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: textColor,
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
