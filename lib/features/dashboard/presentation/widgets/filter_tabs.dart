import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/dashboard_provider.dart';

class FilterTabs extends StatelessWidget {
  final FilterType selectedFilter;
  final int allCount;
  final int pendingCount;
  final int approvedCount;
  final Function(FilterType) onFilterChanged;

  const FilterTabs({
    Key? key,
    required this.selectedFilter,
    required this.allCount,
    required this.pendingCount,
    required this.approvedCount,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildFilterChip(
          label: 'All Requests',
          count: allCount,
          isSelected: selectedFilter == FilterType.all,
          onTap: () => onFilterChanged(FilterType.all),
        ),
        SizedBox(width: 12.w),
        _buildFilterChip(
          label: 'Pending',
          count: pendingCount,
          isSelected: selectedFilter == FilterType.pending,
          onTap: () => onFilterChanged(FilterType.pending),
        ),
        SizedBox(width: 12.w),
        _buildFilterChip(
          label: 'Approved',
          count: approvedCount,
          isSelected: selectedFilter == FilterType.approved,
          onTap: () => onFilterChanged(FilterType.approved),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.backgroundLight : AppColors.greyLight,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyDark,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.backgroundMedium
                    : AppColors.greyMedium,
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primary : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}