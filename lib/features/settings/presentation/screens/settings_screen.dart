import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/app_settings.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const Color primaryNavy = Color(0xFF14264F);
  static const Color primaryBlue = Color(0xFF286BE8);
  static const Color accentCyan = Color(0xFF50CBE0);
  static const Color paleBlueBackground = Color(0xFFEAF2FF);
  static const Color secondaryText = Color(0xFF536584);
  static const Color mutedText = Color(0xFF7485A3);
  static const Color inputBorder = Color(0xFFD6E2F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              paleBlueBackground,
              Colors.white,
            ],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: settingsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlue,
                    ),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Failed to load settings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: secondaryText,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.refresh(settingsProvider),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  data: (settings) => _buildSettingsContent(context, ref, settings),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: primaryNavy.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: primaryNavy,
              ),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PREFERENCES',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: primaryBlue,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryNavy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final notifier = ref.read(settingsProvider.notifier);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _buildSectionHeader('NOTIFICATIONS'),
        const SizedBox(height: 8),
        _buildCard(
          children: [
            _buildSwitchTile(
              title: 'Enable Notifications',
              subtitle: 'Receive updates and alerts',
              value: settings.notificationsEnabled,
              onChanged: (val) => notifier.toggleNotifications(val),
              icon: Icons.notifications_active_outlined,
            ),
            if (settings.notificationsEnabled) ...[
              const Divider(height: 1, color: inputBorder),
              _buildSwitchTile(
                title: 'Email Notifications',
                subtitle: 'Get job updates via email',
                value: settings.emailNotificationsEnabled,
                onChanged: (val) => notifier.toggleEmailNotifications(val),
                icon: Icons.mail_outline_rounded,
              ),
              const Divider(height: 1, color: inputBorder),
              _buildSwitchTile(
                title: 'Push Notifications',
                subtitle: 'Real-time alerts on your device',
                value: settings.pushNotificationsEnabled,
                onChanged: (val) => notifier.togglePushNotifications(val),
                icon: Icons.cell_tower_rounded,
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader('PREFERENCES'),
        const SizedBox(height: 8),
        _buildCard(
          children: [
            _buildDropdownTile(
              title: 'Language',
              subtitle: 'Select application language',
              value: settings.language,
              icon: Icons.language_rounded,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'am', child: Text('Amharic (አማርኛ)')),
                DropdownMenuItem(value: 'om', child: Text('Afaan Oromoo')),
              ],
              onChanged: (val) {
                if (val != null) {
                  notifier.updateLanguage(val);
                }
              },
            ),
            const Divider(height: 1, color: inputBorder),
            _buildDropdownTile(
              title: 'Theme Mode',
              subtitle: 'Choose display theme',
              value: settings.themeMode,
              icon: Icons.palette_outlined,
              items: const [
                DropdownMenuItem(value: 'light', child: Text('Light')),
                DropdownMenuItem(value: 'dark', child: Text('Dark')),
                DropdownMenuItem(value: 'system', child: Text('System')),
              ],
              onChanged: (val) {
                if (val != null) {
                  notifier.updateThemeMode(val);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader('ACCOUNT'),
        const SizedBox(height: 8),
        _buildCard(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: paleBlueBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: primaryNavy,
                  size: 20,
                ),
              ),
              title: const Text(
                'User Account',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryNavy,
                ),
              ),
              subtitle: Text(
                settings.userId,
                style: const TextStyle(
                  fontSize: 12,
                  color: secondaryText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
          color: primaryBlue,
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: inputBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryNavy.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeThumbColor: primaryBlue,
      activeTrackColor: primaryBlue.withValues(alpha: 0.3),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: inputBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: paleBlueBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: primaryNavy,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryNavy,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: secondaryText,
        ),
      ),
    );
  }

  Widget _buildDropdownTile<T>({
    required String title,
    required String subtitle,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: paleBlueBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: primaryNavy,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryNavy,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: secondaryText,
        ),
      ),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryNavy,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: primaryBlue,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
