import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const RegistrationTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines,
    this.maxLength,
    this.readOnly,
    this.enabled,
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  State<RegistrationTextField> createState() => _RegistrationTextFieldState();
}

class _RegistrationTextFieldState extends State<RegistrationTextField> {
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
          onTap: widget.onTap ?? () {},
          obscureText: widget.obscureText,
          obscuringCharacter: "*",
          enabled: widget.enabled,
          readOnly: widget.readOnly ?? false,
          validator: widget.validator,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(252, 255, 253, 1),
            // isTyping
            //     ? const Color.fromRGBO(232, 245, 239, 1)
            //     : const Color.fromRGBO(252, 255, 253, 1),
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: const Color.fromRGBO(189, 189, 189, 1),
              fontSize: 14.sp,
            ),
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),
          ),
        ),
      ],
    );
  }
}