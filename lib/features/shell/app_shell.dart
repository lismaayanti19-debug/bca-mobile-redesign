import 'package:flutter/material.dart';

import '../account/account_page.dart';
import '../activity/activity_page.dart';
import '../home/home_page.dart';
import '../home/widgets/home_sheets.dart';
import '../promo/promo_page.dart';
import 'widgets/bca_bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    if (index == 2) {
      showQrisSheet(context);
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            onSeeAllTransactions: () => _onNavTap(1),
            onSeeAllPromos: () => _onNavTap(3),
          ),
          const ActivityPage(),
          const SizedBox.shrink(),
          const PromoPage(),
          const AccountPage(),
        ],
      ),
      bottomNavigationBar: BcaBottomNav(
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
