import 'dart:io';
import 'package:e_consular_card/features/auth/presentation/screens/otp_verification_page.dart';
import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
import 'package:e_consular_card/features/auth/presentation/widget/file_picker_field.dart';
import 'package:e_consular_card/features/auth/presentation/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterWithoutNinPage extends StatefulWidget {
  const RegisterWithoutNinPage({Key? key}) : super(key: key);

  @override
  State<RegisterWithoutNinPage> createState() => _RegisterWithoutNinPageState();
}

class _RegisterWithoutNinPageState extends State<RegisterWithoutNinPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _birthCertificate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFilePicked(File? file) {
    setState(() {
      _birthCertificate = file;
    });
  }

  Future<void> _handleRegister() async {
    // Validate file selection first
    if (_birthCertificate == null) {
      showErrorSnackbar(context, 'Please select your birth certificate');
      return;
    }

    // Validate form
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    showLoadingDialog(context);

    final success = await authProvider.registerManually(
         firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text.trim(),
      password: _passwordController.text,
      birthCertificate: _birthCertificate!,
   
    );

    if (!mounted) return;
    hideLoadingDialog(context);

    if (success) {
      // showSuccessSnackbar(context, 'Account created successfully!');

      // Navigate to OTP screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OtpVerificationPage(),
        ),
      );
    } else {
      final errorMessage = authProvider.errorMessage;

      if (errorMessage != null && errorMessage.contains('already registered')) {
        showErrorSnackbar(
          context,
          'Email is already registered to an account. Please log in!',
        );
      } else {
        showErrorSnackbar(
          context,
          errorMessage ?? 'Registration failed. Please try again.',
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: const Text('Account created. OTP screen will be added next.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAuthAppBar(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Get your account ready to get any confidential\ndocument you need to.",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  _buildForm(),
                  SizedBox(height: 20.h),
                  buildAlreadyHaveAccount(context, () {
                    // TODO: Navigate to login
                    showErrorSnackbar(context, 'Login screen coming next!');
                  }),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("First Name*", style: TextStyle(fontSize: 14.sp)),
          SizedBox(height: 10.h),
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Enter your First Name",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "First Name is required";
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),

          //last name
          Text("Last Name*", style: TextStyle(fontSize: 14.sp)),

          SizedBox(height: 10.h),
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Enter your Last Name",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Last Name is required";
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          // Email
          Text("Email*", style: TextStyle(fontSize: 14.sp)),
          SizedBox(height: 10.h),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your Email",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
            validator: validateEmail,
          ),
          SizedBox(height: 16.h),

          // Birth Certificate
          Text(
            "Select Birth Certificate*",
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 10.h),
          FilePickerField(
            onFilePicked: _onFilePicked,
          ),
          SizedBox(height: 16.h),

          // Password
          PasswordField(
            title: "Password*",
            hint: "Create a Password",
            controller: _passwordController,
            validator: validatePassword,
          ),
          SizedBox(height: 16.h),

          // Confirm Password
          PasswordField(
            title: "Confirm Password*",
            hint: "Confirm Password",
            controller: _confirmPasswordController,
            validator: (value) => validateConfirmPassword(
              value,
              _passwordController.text,
            ),
          ),
          SizedBox(height: 30.h),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff24985B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
