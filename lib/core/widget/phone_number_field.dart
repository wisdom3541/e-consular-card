import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneNumberField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? dialCode;
  final String hint;
  final int? maxLength;
  final String? Function(String?)? validator;

  const PhoneNumberField({
    Key? key,
    required this.label,
    required this.controller,
    this.dialCode,
    required this.hint,
    this.validator,
    this.maxLength
  }) : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final typing = widget.controller.text.isNotEmpty;
      if (typing != isTyping) {
        setState(() {
          isTyping = typing;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(41, 41, 41, 1),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          maxLength: widget.maxLength,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: isTyping
                ? const Color.fromRGBO(232, 245, 239, 1)
                : const Color.fromRGBO(252, 255, 253, 1),
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: const Color.fromRGBO(189, 189, 189, 1),
              fontSize: 14.sp,
            ),
            prefixIcon: widget.dialCode != null
                ? Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(232, 245, 239, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.dialCode!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(41, 41, 41, 1),
                        ),
                      ),
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: widget.dialCode != null ? 0 : 16.w,
            ),
          ),
        ),
      ],
    );
  }
}