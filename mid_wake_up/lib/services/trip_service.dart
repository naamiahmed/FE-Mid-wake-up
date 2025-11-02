import '../models/trip_model.dart';
import 'storage_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TripService {
  final StorageService _storageService = StorageService();
  static const String _keyTrips = 'trips';
  static const String _keyActiveTrip = 'active_trip';

  Future<List<TripModel>> getRecentTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripsJson = prefs.getString(_keyTrips);
    if (tripsJson != null) {
      final List<dynamic> tripsList = jsonDecode(tripsJson);
      return tripsList.map((t) => TripModel.fromJson(t)).toList();
    }
    return [];
  }

  Future<void> saveTrip(TripModel trip) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getRecentTrips();
    trips.insert(0, trip);
    await prefs.setString(_keyTrips, jsonEncode(trips.map((t) => t.toJson()).toList()));
  }

  Future<TripModel?> startTrip(String destination, String destinationDetails) async {
    final trip = TripModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      destination: destination,
      destinationDetails: destinationDetails,
      distance: 12.5,
      duration: 45,
      startTime: DateTime.now(),
      status: TripStatus.active,
      progress: 0.0,
    );
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyActiveTrip, jsonEncode(trip.toJson()));
    return trip;
  }

  Future<TripModel?> getActiveTrip() async {
    final prefs = await SharedPreferences.getInstance();
    final tripJson = prefs.getString(_keyActiveTrip);
    if (tripJson != null) {
      return TripModel.fromJson(jsonDecode(tripJson));
    }
    return null;
  }

  Future<void> updateActiveTrip(TripModel trip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyActiveTrip, jsonEncode(trip.toJson()));
  }

  Future<TripModel> endTrip(TripModel trip) async {
    final completedTrip = trip.copyWith(
      status: TripStatus.completed,
      endTime: DateTime.now(),
      progress: 1.0,
    );
    
    await saveTrip(completedTrip);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyActiveTrip);
    
    return completedTrip;
  }
}

