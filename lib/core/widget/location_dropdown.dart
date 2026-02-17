import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationDropdown<T> extends StatefulWidget {
  final String label;
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) getLabel;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;
  final bool isLoading;

  const LocationDropdown({
    Key? key,
    required this.label,
    required this.hint,
    required this.items,
    required this.getLabel,
    required this.onChanged,
    this.value,
    this.validator,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<LocationDropdown<T>> createState() => _LocationDropdownState<T>();
}

class _LocationDropdownState<T> extends State<LocationDropdown<T>> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value != null;
  }

  @override
  void didUpdateWidget(LocationDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        isSelected = widget.value != null;
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
        
        widget.isLoading
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(252, 255, 253, 1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )
            : DropdownButtonFormField<T>(
                value: widget.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isSelected
                      ? const Color.fromRGBO(232, 245, 239, 1)
                      : const Color.fromRGBO(252, 255, 253, 1),
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
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      widget.getLabel(item),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(41, 41, 41, 1),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    isSelected = value != null;
                  });
                  widget.onChanged(value);
                },
                validator: widget.validator,
              ),
      ],
    );
  }
}