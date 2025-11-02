import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../viewmodels/trip_viewmodel.dart';
import '../../viewmodels/settings_viewmodel.dart';

class RecentTripsScreen extends StatelessWidget {
  const RecentTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Recent Trips', style: AppTextStyles.h2()),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRouteDeviationCard(),
            const SizedBox(height: 24),
            _buildRecentTripsHeader(context),
            const SizedBox(height: 16),
            _buildTripsList(),
            const SizedBox(height: 24),
            _buildTravelStats(),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 32),
          ],
        ),
      ),
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
            border: Border(
              left: BorderSide(color: AppColors.green, width: 4),
            ),
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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: AppColors.green,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Route Deviation Alerts',
                      style: AppTextStyles.bodyLarge(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Active monitoring enabled',
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

  Widget _buildRecentTripsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Trips',
          style: AppTextStyles.h3(),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'View All',
            style: AppTextStyles.bodyMedium(color: AppColors.primaryBlue),
          ),
        ),
      ],
    );
  }

  Widget _buildTripsList() {
    return Consumer<TripViewModel>(
      builder: (context, tripViewModel, child) {
        final trips = tripViewModel.recentTrips;

        if (trips.isEmpty) {
          // Show demo trips
          return Column(
            children: [
              _buildTripItem(
                destination: 'Central Station',
                date: 'Oct 30, 2025',
                duration: '45 min',
                distance: '12.5 km',
              ),
              const SizedBox(height: 12),
              _buildTripItem(
                destination: 'Downtown Mall',
                date: 'Oct 28, 2025',
                duration: '30 min',
                distance: '8.2 km',
              ),
              const SizedBox(height: 12),
              _buildTripItem(
                destination: 'Airport Terminal 2',
                date: 'Oct 25, 2025',
                duration: '1h 15min',
                distance: '35 km',
              ),
            ],
          );
        }

        return Column(
          children: trips.map((trip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildTripItem(
                destination: trip.destination,
                date: '${trip.startTime.day}/${trip.startTime.month}/${trip.startTime.year}',
                duration: '${trip.duration} min',
                distance: '${trip.distance} km',
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildTripItem({
    required String destination,
    required String date,
    required String duration,
    required String distance,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: AppColors.primaryBlue, width: 4),
        ),
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
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.flight_takeoff,
              color: AppColors.primaryBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        destination,
                        style: AppTextStyles.bodyLarge(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Completed',
                        style: AppTextStyles.bodySmall(color: AppColors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(date, style: AppTextStyles.bodySmall()),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(duration, style: AppTextStyles.bodySmall()),
                    const SizedBox(width: 16),
                    Icon(Icons.location_on, size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(distance, style: AppTextStyles.bodySmall()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.lightPurple, AppColors.white],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.primaryPurple, size: 24),
              const SizedBox(width: 8),
              Text(
                'Your Travel Stats',
                style: AppTextStyles.h3(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('24', 'Total Trips', AppColors.primaryPurple),
              _buildStatItem('156 km', 'Distance', AppColors.primaryBlue),
              _buildStatItem('18h', 'Time Saved', AppColors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h2(color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall(),
        ),
      ],
    );
  }
}

