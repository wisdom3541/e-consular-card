import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import 'register_with_nin_page.dart';

class NinVerificationPage extends StatefulWidget {
  const NinVerificationPage({Key? key}) : super(key: key);

  @override
  State<NinVerificationPage> createState() => _NinVerificationPageState();
}

class _NinVerificationPageState extends State<NinVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _ninController = TextEditingController();

  @override
  void dispose() {
    _ninController.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyNin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    showLoadingDialog(context);

    final success = await authProvider.verifyNin(_ninController.text.trim());

    if (!mounted) return;
    hideLoadingDialog(context);

    if (success) {
      showSuccessSnackbar(context, 'NIN verified successfully!');
      
      // Navigate to registration page with prefilled NIN
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterWithNinPage(),
        ),
      );
    } else {
      showErrorSnackbar(
        context,
        authProvider.errorMessage ?? 'NIN verification failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                
                SizedBox(height: 20.h),
                
                // Title
                Text(
                  'Verify Your NIN',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 12.h),
                
                // Subtitle
                Text(
                  'Enter your National Identity Number to continue with registration',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                
                SizedBox(height: 40.h),
                
                // Info card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Your NIN will be used to verify your identity and retrieve your information from the national database.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'National Identity Number (NIN)*',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: _ninController,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        decoration: InputDecoration(
                          hintText: 'Enter your 11-digit NIN',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14.sp,
                          ),
                          prefixIcon: const Icon(Icons.credit_card),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          counterText: '', // Hide counter
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your NIN';
                          }
                          if (value.length != 11) {
                            return 'NIN must be exactly 11 digits';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'NIN must contain only numbers';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40.h),
                
                // Verify button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleVerifyNin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Text(
                      'Verify NIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                // Help text
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Show help dialog or navigate to help page
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Need Help?'),
                          content: const Text(
                            'Your NIN is an 11-digit number issued by the National Identity Management Commission (NIMC). '
                            'You can find it on your NIN slip or by sending NIN to 346 via SMS.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Don\'t know your NIN?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}