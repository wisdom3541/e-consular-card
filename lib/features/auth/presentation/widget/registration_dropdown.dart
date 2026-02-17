import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationDropdown extends StatefulWidget {
  final String label;
  final String hint;
  final String? value;
  final List<DropdownItem> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const RegistrationDropdown({
    Key? key,
    required this.label,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
  }) : super(key: key);

  @override
  State<RegistrationDropdown> createState() => _RegistrationDropdownState();
}

class _RegistrationDropdownState extends State<RegistrationDropdown> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value != null && widget.value!.isNotEmpty;
  }

  @override
  void didUpdateWidget(RegistrationDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        isSelected = widget.value != null && widget.value!.isNotEmpty;
      });
    }
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
        DropdownButtonFormField<String>(
          value: widget.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: isSelected
                ? const Color.fromRGBO(232, 245, 239, 1) // Light green when selected
                : const Color.fromRGBO(252, 255, 253, 1), // Default
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: const Color.fromRGBO(189, 189, 189, 1),
              fontSize: 14.sp,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: const Color.fromRGBO(189, 189, 189, 1),
            size: 24.sp,
          ),
          isExpanded: true,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item.value,
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(41, 41, 41, 1),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              isSelected = value != null && value.isNotEmpty;
            });
            widget.onChanged(value);
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}

// Helper class for dropdown items
class DropdownItem {
  final String value;
  final String label;

  const DropdownItem({
    required this.value,
    required this.label,
  });
}