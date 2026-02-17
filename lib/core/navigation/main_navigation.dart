import 'package:e_consular_card/config/injection.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/card_request_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/card_request_provider.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:e_consular_card/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:e_consular_card/features/payments/presentation/providers/payment_provider.dart';
import 'package:e_consular_card/features/payments/presentation/screen/payment_page.dart';
import 'package:e_consular_card/features/signature/presentation/screens/signature_page.dart';
import 'package:e_consular_card/features/support/presentation/providers/support_provider.dart';
import 'package:e_consular_card/features/support/presentation/screens/support_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    PaymentsPage(),
    SignaturePage(),
    SupportPage(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 5,
        indicatorColor: AppColors.textWhite,
        backgroundColor: AppColors.backgroundLight,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.dashboard, color: AppColors.primary),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.payment_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.payment, color: AppColors.primary),
            label: "My Payment",
          ),
          NavigationDestination(
            icon: Icon(Icons.draw_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.draw, color: AppColors.primary),
            label: "Add Signature",
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.support_agent, color: AppColors.primary),
            label: "Support Ticket",
          ),
        ],
      ),
    );
  }
}