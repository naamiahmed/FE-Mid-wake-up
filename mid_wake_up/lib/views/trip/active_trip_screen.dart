import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../viewmodels/trip_viewmodel.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../../models/trip_model.dart';

class ActiveTripScreen extends StatefulWidget {
  const ActiveTripScreen({super.key});

  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  @override
  void initState() {
    super.initState();
    // Start a demo trip if none exists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tripViewModel = Provider.of<TripViewModel>(context, listen: false);
      if (tripViewModel.activeTrip == null) {
        tripViewModel.startTrip(
          'Central Station',
          'Central Station, Platform 5',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0xFFE0F2FE), AppColors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildMapSection(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      _buildTripInfoCard(),
                      const SizedBox(height: 16),
                      _buildWakeUpAlarmCard(),
                      const SizedBox(height: 16),
                      _buildRouteDeviationCard(),
                      const SizedBox(height: 24),
                      _buildEndTripButton(context),
                      const SizedBox(height: 16),
                      Text(
                        'Your trip is being tracked safely',
                        style: AppTextStyles.bodySmall(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          // Origin marker
          Positioned(
            left: 40,
            top: 60,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Destination marker
          Positioned(
            right: 40,
            top: 40,
            child: const Icon(
              Icons.location_on,
              color: AppColors.red,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripInfoCard() {
    return Consumer<TripViewModel>(
      builder: (context, tripViewModel, child) {
        final trip = tripViewModel.activeTrip;
        if (trip == null) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Loading trip...',
                    style: AppTextStyles.bodyMedium(),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.flight_takeoff,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Destination',
                          style: AppTextStyles.bodySmall(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          trip.destinationDetails,
                          style: AppTextStyles.h3(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoColumn(
                      icon: Icons.access_time,
                      label: 'ETA',
                      value: '${trip.duration} min',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoColumn(
                      icon: Icons.location_on,
                      label: 'Distance',
                      value: '${trip.distance} km',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Progress',
                style: AppTextStyles.bodySmall(),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: trip.progress,
                      backgroundColor: AppColors.backgroundColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                      minHeight: 8,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '${(trip.progress * 100).toInt()}%',
                        style: AppTextStyles.bodySmall(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoColumn({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.textPrimary, size: 24),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodySmall()),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.bodyLarge(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildWakeUpAlarmCard() {
    return Consumer<SettingsViewModel>(
      builder: (context, settingsViewModel, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: AppColors.primaryPurple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wake-Up Alarm',
                      style: AppTextStyles.bodyLarge(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Alert ${settingsViewModel.settings.alarmMinutesBeforeArrival} min before arrival',
                      style: AppTextStyles.bodyMedium(),
                    ),
                  ],
                ),
              ),
              Switch(
                value: settingsViewModel.settings.isAlarmEnabled,
                onChanged: (value) => settingsViewModel.updateAlarmEnabled(value),
                activeColor: AppColors.textPrimary,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRouteDeviationCard() {
    return Consumer<SettingsViewModel>(
      builder: (context, settingsViewModel, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shield,
                  color: AppColors.green,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Route Deviation Alert',
                      style: AppTextStyles.bodyLarge(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Monitoring route changes',
                      style: AppTextStyles.bodyMedium(),
                    ),
                  ],
                ),
              ),
              Switch(
                value: settingsViewModel.settings.isRouteDeviationAlertsEnabled,
                onChanged: (value) => settingsViewModel.updateRouteDeviationAlerts(value),
                activeColor: AppColors.textPrimary,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEndTripButton(BuildContext context) {
    return Consumer<TripViewModel>(
      builder: (context, tripViewModel, child) {
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: tripViewModel.isLoading
                ? null
                : () async {
                    try {
                      await tripViewModel.endTrip();
                      if (context.mounted) {
                        context.go('/trip-completed');
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error ending trip: ${e.toString()}')),
                        );
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: tripViewModel.isLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.red,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('End Trip', style: AppTextStyles.button()),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

