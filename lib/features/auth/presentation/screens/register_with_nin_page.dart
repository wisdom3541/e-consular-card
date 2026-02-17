// import 'package:e_consular_card/features/auth/presentation/screens/otp_verification_page.dart';
// import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
// import 'package:e_consular_card/features/auth/presentation/widget/password_field.dart';
// import 'package:e_consular_card/screens/createAccountWithNIN.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';

// class RegisterWithNinPage extends StatefulWidget {
//   const RegisterWithNinPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterWithNinPage> createState() => _RegisterWithNinPageState();
// }

// class _RegisterWithNinPageState extends State<RegisterWithNinPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleRegister() async {
//   if (!_formKey.currentState!.validate()) return;

//   final authProvider = context.read<AuthProvider>();
//   final nin = authProvider.prefilledNin;

//   if (nin == null || nin.isEmpty) {
//     showErrorSnackbar(context, 'NIN is missing. Please go back and verify your NIN.');
//     return;
//   }

//   showLoadingDialog(context);

//   final success = await authProvider.registerWithNin(
//     email: _emailController.text.trim(),
//     nin: nin,
//     password: _passwordController.text,
//   );

//   if (!mounted) return;
//   hideLoadingDialog(context);

//   if (success) {
//     showSuccessSnackbar(context, 'Account created successfully!');
    
//     // Navigate to OTP screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const OtpVerificationPage(
//           title: "Enter OTP sent to your mail",
//           message: "We sent an OTP to your email to verify your account",
//         ),
//       ),
//     );
//   } else {
//     showErrorSnackbar(
//       context,
//       authProvider.errorMessage ?? 'Registration failed',
//     );
//   }
// }

//   // void _showSuccessDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Success!'),
//   //       content: const Text('Account created. OTP screen will be added next.'),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context),
//   //           child: const Text('OK'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = context.watch<AuthProvider>();
//     final nin = authProvider.prefilledNin ?? '';

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             buildAuthAppBar(),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Column(
//                 children: [
//                   SizedBox(height: 30.h),
//                   Text(
//                     "Create an account",
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "Get your account ready to get any confidential\ndocument you need to.",
//                     style: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 30.h),
//                   _buildForm(nin),
//                   SizedBox(height: 20.h),
//                   buildAlreadyHaveAccount(context, () {
//                     // TODO: Navigate to login
//                     showErrorSnackbar(context, 'Login screen coming next!');
//                   }),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildForm(String nin) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Email
//           Text("Email*", style: TextStyle(fontSize: 14.sp)),
//           SizedBox(height: 10.h),
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               hintText: "Enter your Email",
//               hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
//               ),
//             ),
//             validator: validateEmail,
//           ),
//           SizedBox(height: 16.h),

//           // NIN (disabled/prefilled)
//           Text(
//             "National Identity Number (NIN)*",
//             style: TextStyle(fontSize: 14.sp),
//           ),
//           SizedBox(height: 10.h),
//           TextFormField(
//             initialValue: nin,
//             enabled: false,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.grey[200],
//               hintText: "NIN",
//               hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),

//           // Password
//           PasswordField(
//             title: "Password*",
//             hint: "Create a Password",
//             controller: _passwordController,
//             validator: validatePassword,
//           ),
//           SizedBox(height: 16.h),

//           // Confirm Password
//           PasswordField(
//             title: "Confirm Password*",
//             hint: "Confirm Password",
//             controller: _confirmPasswordController,
//             validator: (value) => validateConfirmPassword(
//               value,
//               _passwordController.text,
//             ),
//           ),
//           SizedBox(height: 30.h),

//           // Submit Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _handleRegister,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff24985B),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//               ),
//               child: Text(
//                 "Create Account",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16.sp,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
import 'package:e_consular_card/features/auth/presentation/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import 'otp_verification_page.dart';

class RegisterWithNinPage extends StatefulWidget {
  const RegisterWithNinPage({Key? key}) : super(key: key);

  @override
  State<RegisterWithNinPage> createState() => _RegisterWithNinPageState();
}

class _RegisterWithNinPageState extends State<RegisterWithNinPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    showLoadingDialog(context);

    final success = await authProvider.registerWithNin(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;
    hideLoadingDialog(context);

    if (success) {
      // Navigate to OTP verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OtpVerificationPage(),
        ),
      );
    } else {
      showErrorSnackbar(
        context,
        authProvider.errorMessage ?? 'Registration failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  appBar: buildAuthAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Subtitle
                  Text(
                    'Register with your verified NIN',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // NIN Info Card
                  Consumer<AuthProvider>(
                    builder: (context, provider, _) {
                      final ninVerification = provider.ninVerification;
                      
                      return Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.verified_user,
                                  color: AppColors.primary,
                                  size: 24.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'NIN Verified',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            if (ninVerification != null) ...[
                              _buildInfoRow('Name', ninVerification.fullName),
                              SizedBox(height: 8.h),
                              _buildInfoRow('NIN', provider.prefilledNin ?? ''),
                            ] else ...[
                              Text(
                                'NIN: ${provider.prefilledNin ?? "Not available"}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 32.h),

                  // Email Field
                  Text(
                    'Email Address*',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: validateEmail,
                  ),

                  SizedBox(height: 20.h),

                  // Password Field
                  Text(
                    'Password*',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  PasswordField(
                    controller: _passwordController,
                   // hintText: 'Enter your password',
                    validator: validatePassword, title: 'Password', hint: 'Enter your password',
                  ),

                  SizedBox(height: 20.h),

                  // Confirm Password Field
                  Text(
                    'Confirm Password*',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  PasswordField(
                    controller: _confirmPasswordController,
                   // hintText: 'Confirm your password',
                    validator: (value) {
                      return validateConfirmPassword(
                        value,
                        _passwordController.text,
                      );
                    }, title: '', hint: 'Confirm your password',
                  ),

                  SizedBox(height: 32.h),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Login Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to login page
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}