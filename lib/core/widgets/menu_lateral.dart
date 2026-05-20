import 'package:coolservice/core/app_config/presentation/viewmodels/app_config_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    final configViewModel = context.watch<AppConfigViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: Column(
        children: [
          _DrawerHeader(colorScheme: colorScheme),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SectionLabel('Principal'),
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Início',
                  onTap: () => Navigator.pop(context),
                ),
                _NavItem(
                  icon: Icons.people_rounded,
                  label: 'Clientes',
                  onTap: () => Navigator.pop(context),
                ),
                _NavItem(
                  icon: Icons.badge_rounded,
                  label: 'Funcionários',
                  onTap: () => Navigator.pop(context),
                ),
                _NavItem(
                  icon: Icons.assignment_rounded,
                  label: 'Ordens de Serviço',
                  badge: '3',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(indent: 16, endIndent: 16),
                _SectionLabel('Preferências'),
                _ThemeToggle(configViewModel: configViewModel),
              ],
            ),
          ),
          const _DrawerFooter(),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  const _DrawerHeader({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      decoration: const BoxDecoration(color: Color(0xFF1a1a2e)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.18)),
            ),
            child: const Icon(
              Icons.build_rounded,
              color: Color(0xFFa5b4fc),
              size: 26,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'CoolService App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'sprint2_v1.0@coolservice.com',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFa5b4fc).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFa5b4fc).withOpacity(0.3),
              ),
            ),
            child: const Text(
              'v1.0.0',
              style: TextStyle(color: Color(0xFFa5b4fc), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF6366f1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge!,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final AppConfigViewModel configViewModel;
  const _ThemeToggle({required this.configViewModel});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(
        configViewModel.isDarkMode
            ? Icons.dark_mode_rounded
            : Icons.light_mode_rounded,
      ),
      title: const Text('Modo Escuro', style: TextStyle(fontSize: 14)),
      value: configViewModel.isDarkMode,
      onChanged: configViewModel.toggleTheme,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: 8),
          Text(
            'CoolService v1.0.0',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
