enum TripStatus {
  active,
  completed,
  cancelled,
  onTime,
  delayed,
}

class TripModel {
  final String id;
  final String destination;
  final String destinationDetails;
  final double distance;
  final int duration; // in minutes
  final DateTime startTime;
  final DateTime? endTime;
  final TripStatus status;
  final double progress; // 0.0 to 1.0
  final bool hasRouteDeviations;
  final String? routeDeviationsMessage;

  TripModel({
    required this.id,
    required this.destination,
    required this.destinationDetails,
    required this.distance,
    required this.duration,
    required this.startTime,
    this.endTime,
    this.status = TripStatus.active,
    this.progress = 0.0,
    this.hasRouteDeviations = false,
    this.routeDeviationsMessage,
  });

  TripModel copyWith({
    String? id,
    String? destination,
    String? destinationDetails,
    double? distance,
    int? duration,
    DateTime? startTime,
    DateTime? endTime,
    TripStatus? status,
    double? progress,
    bool? hasRouteDeviations,
    String? routeDeviationsMessage,
  }) {
    return TripModel(
      id: id ?? this.id,
      destination: destination ?? this.destination,
      destinationDetails: destinationDetails ?? this.destinationDetails,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      hasRouteDeviations: hasRouteDeviations ?? this.hasRouteDeviations,
      routeDeviationsMessage: routeDeviationsMessage ?? this.routeDeviationsMessage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destination': destination,
      'destinationDetails': destinationDetails,
      'distance': distance,
      'duration': duration,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'status': status.toString(),
      'progress': progress,
      'hasRouteDeviations': hasRouteDeviations,
      'routeDeviationsMessage': routeDeviationsMessage,
    };
  }

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String,
      destination: json['destination'] as String,
      destinationDetails: json['destinationDetails'] as String,
      distance: (json['distance'] as num).toDouble(),
      duration: json['duration'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      status: TripStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => TripStatus.completed,
      ),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      hasRouteDeviations: json['hasRouteDeviations'] as bool? ?? false,
      routeDeviationsMessage: json['routeDeviationsMessage'] as String?,
    );
  }
}

