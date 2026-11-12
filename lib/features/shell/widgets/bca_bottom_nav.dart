import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/press_scale.dart';

class BcaBottomNav extends StatelessWidget {
  const BcaBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
        boxShadow: [
          BoxShadow(
            color: Color(0x120B2A45),
            blurRadius: 24,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _NavItem(
                key: const Key('nav-beranda'),
                label: 'Beranda',
                icon: Icons.home_rounded,
                outlineIcon: Icons.home_outlined,
                selected: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                key: const Key('nav-aktivitas'),
                label: 'Aktivitas',
                icon: Icons.receipt_long_rounded,
                outlineIcon: Icons.receipt_long_outlined,
                selected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              Expanded(child: _QrisButton(onTap: () => onTap(2))),
              _NavItem(
                key: const Key('nav-promo'),
                label: 'Promo',
                icon: Icons.local_offer_rounded,
                outlineIcon: Icons.local_offer_outlined,
                selected: selectedIndex == 3,
                onTap: () => onTap(3),
              ),
              _NavItem(
                key: const Key('nav-akun'),
                label: 'Akun',
                icon: Icons.person_rounded,
                outlineIcon: Icons.person_outline_rounded,
                selected: selectedIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.outlineIcon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData outlineIcon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.bcaBlue : AppColors.muted;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selected ? icon : outlineIcon, size: 21, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: selected ? 12 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.bcaBlue,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrisButton extends StatelessWidget {
  const _QrisButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -14),
      child: OverflowBox(
        alignment: Alignment.topCenter,
        minHeight: 0,
        maxHeight: 84,
        child: PressScale(
          key: const Key('nav-qris'),
          onTap: onTap,
          scale: 0.92,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0073C8), AppColors.bcaBlue],
                  ),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x400060AF),
                      blurRadius: 16,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'QRIS',
                style: TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  color: AppColors.bcaBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
