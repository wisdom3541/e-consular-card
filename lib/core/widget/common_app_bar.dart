import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final bool showBackButton;
  final Color titleColor;

  const CommonAppBar({
    Key? key,
    this.title = "E-Consular Card",
    this.trailing,
    this.showBackButton = false,
    this.titleColor = AppColors.primaryDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, ),
      color: AppColors.textWhite,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: trailing == null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
                onPressed: () => Navigator.pop(context),
              )
            else
              
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(78.h);
}