import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../services/permission_service.dart';
import '../services/storage_service.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final PermissionService _permissionService = PermissionService();
  bool _isLoading = false;

  Future<void> _grantPermissions() async {
    setState(() => _isLoading = true);

    final granted = await _permissionService.requestAllPermissions();
    
    if (granted) {
      final storageService = StorageService();
      final settings = await storageService.getSettings();
      final updatedSettings = settings.copyWith(hasGrantedPermissions: true);
      await storageService.saveSettings(updatedSettings);
      
      if (mounted) {
        // Always go to home after permissions (supports guest mode)
        context.go('/home');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please grant all permissions')),
        );
      }
    }
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 60,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Permissions Required',
                style: AppTextStyles.h2(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'To provide the best experience, we need the following permissions:',
                style: AppTextStyles.bodyMedium(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildPermissionItem(
                icon: Icons.location_on_outlined,
                title: 'Location Access',
                description: 'Track your journey in real-time',
              ),
              const SizedBox(height: 16),
              _buildPermissionItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                description: 'Receive timely alerts and updates',
              ),
              const SizedBox(height: 16),
              _buildPermissionItem(
                icon: Icons.wifi_outlined,
                title: 'Background Activity',
                description: 'Keep tracking even when app is closed',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _grantPermissions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: AppColors.white)
                      : Text(
                          'Grant Permissions & Continue',
                          style: AppTextStyles.button(),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Skip and go to home (supports guest mode)
                  context.go('/home');
                },
                child: Text(
                  'Skip for now',
                  style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodyMedium(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

