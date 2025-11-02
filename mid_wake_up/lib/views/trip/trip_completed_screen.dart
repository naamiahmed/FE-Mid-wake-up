import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../viewmodels/trip_viewmodel.dart';
import '../../models/trip_model.dart';

class TripCompletedScreen extends StatefulWidget {
  const TripCompletedScreen({super.key});

  @override
  State<TripCompletedScreen> createState() => _TripCompletedScreenState();
}

class _TripCompletedScreenState extends State<TripCompletedScreen> {
  int _rating = 0;
  final _feedbackController = TextEditingController();
  TripModel? _completedTrip;

  @override
  void initState() {
    super.initState();
    _loadCompletedTrip();
  }

  void _loadCompletedTrip() {
    // Get the most recently completed trip
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tripViewModel = Provider.of<TripViewModel>(context, listen: false);
      if (tripViewModel.recentTrips.isNotEmpty) {
        setState(() {
          _completedTrip = tripViewModel.recentTrips.first;
        });
      } else {
        // If no trips, create a demo trip
        setState(() {
          _completedTrip = TripModel(
            id: 'demo',
            destination: 'Central Station',
            destinationDetails: 'Central Station, Platform 5',
            distance: 12.5,
            duration: 45,
            startTime: DateTime.now().subtract(const Duration(minutes: 45)),
            endTime: DateTime.now(),
            status: TripStatus.completed,
            progress: 1.0,
            hasRouteDeviations: false,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _completedTrip == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Green Header
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: AppColors.green,
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Trip Completed!',
                          style: AppTextStyles.h2(color: AppColors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You\'ve arrived safely at your destination',
                          style: AppTextStyles.bodyMedium(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                // White Card - Scrollable
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          _buildTripSummary(_completedTrip!),
                          const SizedBox(height: 24),
                          _buildFeedbackSection(),
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTripSummary(TripModel trip) {
    final actualDuration = trip.endTime != null && trip.startTime != null
        ? trip.endTime!.difference(trip.startTime).inMinutes
        : trip.duration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trip Summary',
          style: AppTextStyles.h3(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primaryBlue, size: 24),
            const SizedBox(width: 12),
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
                    style: AppTextStyles.bodyLarge(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn(
                icon: Icons.flight_takeoff,
                iconColor: AppColors.primaryBlue,
                label: 'Distance',
                value: '${trip.distance.toStringAsFixed(1)} km',
              ),
              _buildStatColumn(
                icon: Icons.access_time,
                iconColor: AppColors.primaryPurple,
                label: 'Duration',
                value: '$actualDuration min',
              ),
              _buildStatColumn(
                icon: Icons.check_circle,
                iconColor: AppColors.green,
                label: 'Status',
                value: trip.status == TripStatus.onTime ? 'On Time' : 'Completed',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: trip.hasRouteDeviations ? AppColors.lightOrange : AppColors.lightGreen,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: trip.hasRouteDeviations ? AppColors.orange : AppColors.green,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                trip.hasRouteDeviations ? Icons.warning : Icons.check_circle,
                color: trip.hasRouteDeviations ? AppColors.orange : AppColors.green,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  trip.hasRouteDeviations
                      ? (trip.routeDeviationsMessage ?? 'Route deviations detected')
                      : 'No route deviations detected',
                  style: AppTextStyles.bodyMedium(
                    color: trip.hasRouteDeviations ? AppColors.orange : AppColors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 32),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodySmall()),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyLarge(
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How was your trip?',
          style: AppTextStyles.h3(),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: index < _rating ? AppColors.orange : AppColors.textLight,
                  size: 40,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Text(
          'Share your experience (optional)',
          style: AppTextStyles.bodyMedium(),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _feedbackController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Tell us about your trip...',
            filled: true,
            fillColor: AppColors.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Save feedback if needed
              context.go('/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('Submit', style: AppTextStyles.button()),
          ),
        ),
      ],
    );
  }
}
