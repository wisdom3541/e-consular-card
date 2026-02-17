import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.title, style: TextStyle(fontSize: 14.sp)),
        // SizedBox(height: 10.h),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() => _obscureText = !_obscureText);
              },
            ),
          ),
        ),
      ],
    );
  }
}