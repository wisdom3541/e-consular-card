import 'dart:async';
import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/navigation/main_navigation.dart';
import '../providers/auth_provider.dart';

class LoginOtpVerificationPage extends StatefulWidget {
  const LoginOtpVerificationPage({Key? key}) : super(key: key);

  @override
  State<LoginOtpVerificationPage> createState() =>
      _LoginOtpVerificationPageState();
}

class _LoginOtpVerificationPageState extends State<LoginOtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _resendCountdown = 60;
  Timer? _timer;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
   // _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _resendCountdown = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _handleVerifyOtp() async {
    if (_currentOtp.length != 6) {
      showErrorSnackbar(context, 'Please enter complete OTP');
      return;
    }

    final authProvider = context.read<AuthProvider>();

    showLoadingDialog(context);

    final success = await authProvider.verifyLoginOtp(_currentOtp);

    if (!mounted) return;
    hideLoadingDialog(context);

    if (success) {
      showSuccessSnackbar(context, 'Login successful!');

      // Navigate to main app
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
        (route) => false,
      );
    } else {
      showErrorSnackbar(
        context,
        authProvider.errorMessage ?? 'OTP verification failed',
      );
    }
  }

  // Future<void> _handleResendOtp() async {
  //   if (_resendCountdown > 0) return;

  //   final authProvider = context.read<AuthProvider>();

  //   showLoadingDialog(context);

  //   final success = await authProvider.resendLoginOtp();

  //   if (!mounted) return;
  //   hideLoadingDialog(context);

  //   if (success) {
  //     showSuccessSnackbar(context, 'OTP sent successfully!');
  //     _startCountdown();
  //   } else {
  //     showErrorSnackbar(
  //       context,
  //       authProvider.errorMessage ?? 'Failed to resend OTP',
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: buildAuthAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify Login',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Consumer<AuthProvider>(
                    builder: (context, provider, _) {
                      return Text(
                        'Enter the 6-digit code sent to\n${provider.loginEmail ?? "your email"}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 40.h),

                  // OTP Reference (Debug)
                  Consumer<AuthProvider>(
                    builder: (context, provider, _) {
                      if (provider.loginOtpReference != null) {
                        return Container(
                          padding: EdgeInsets.all(12.w),
                          margin: EdgeInsets.only(bottom: 20.h),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.primary,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Debug OTP: ${provider.loginOtpReference}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // PIN Code Fields
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12.r),
                      fieldHeight: 56.h,
                      fieldWidth: 48.w,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: AppColors.primary,
                      inactiveColor: Colors.grey.shade300,
                      selectedColor: AppColors.primary,
                      errorBorderColor: Colors.red,
                    ),
                    cursorColor: AppColors.primary,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (value) {
                      setState(() {
                        _currentOtp = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _currentOtp = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),

                  SizedBox(height: 32.h),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _currentOtp.length == 6 ? _handleVerifyOtp : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Verify & Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Resend OTP
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _resendCountdown > 0
                            ? Text(
                                'Resend code in $_resendCountdown seconds',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : TextButton(
                                onPressed: (){},
                                child: Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    fontSize: 15.sp,
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
}