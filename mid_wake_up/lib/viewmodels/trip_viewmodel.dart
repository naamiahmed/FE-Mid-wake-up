import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../services/trip_service.dart';

class TripViewModel extends ChangeNotifier {
  final TripService _tripService = TripService();
  TripModel? _activeTrip;
  List<TripModel> _recentTrips = [];
  bool _isLoading = false;

  TripModel? get activeTrip => _activeTrip;
  List<TripModel> get recentTrips => _recentTrips;
  bool get isLoading => _isLoading;

  TripViewModel() {
    _loadTrips();
    _loadActiveTrip();
  }

  Future<void> _loadTrips() async {
    _recentTrips = await _tripService.getRecentTrips();
    notifyListeners();
  }

  Future<void> _loadActiveTrip() async {
    _activeTrip = await _tripService.getActiveTrip();
    notifyListeners();
  }

  Future<TripModel?> startTrip(String destination, String destinationDetails) async {
    _isLoading = true;
    notifyListeners();

    _activeTrip = await _tripService.startTrip(destination, destinationDetails);
    _isLoading = false;
    notifyListeners();
    return _activeTrip;
  }

  Future<void> updateTripProgress(double progress) async {
    if (_activeTrip != null) {
      _activeTrip = _activeTrip!.copyWith(progress: progress);
      await _tripService.updateActiveTrip(_activeTrip!);
      notifyListeners();
    }
  }

  Future<TripModel> endTrip() async {
    if (_activeTrip != null) {
      final completedTrip = await _tripService.endTrip(_activeTrip!);
      _activeTrip = null;
      await _loadTrips();
      notifyListeners();
      return completedTrip;
    }
    throw Exception('No active trip to end');
  }

  Future<void> refreshTrips() async {
    await _loadTrips();
  }
}

