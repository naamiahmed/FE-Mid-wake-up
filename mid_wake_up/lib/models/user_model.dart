class UserModel {
  final String id;
  final String fullName;
  final String email;
  final bool isPremium;
  final int remainingTrips;
  final int totalTrips;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.isPremium = false,
    this.remainingTrips = 5,
    this.totalTrips = 0,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    bool? isPremium,
    int? remainingTrips,
    int? totalTrips,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      isPremium: isPremium ?? this.isPremium,
      remainingTrips: remainingTrips ?? this.remainingTrips,
      totalTrips: totalTrips ?? this.totalTrips,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'isPremium': isPremium,
      'remainingTrips': remainingTrips,
      'totalTrips': totalTrips,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      isPremium: json['isPremium'] as bool? ?? false,
      remainingTrips: json['remainingTrips'] as int? ?? 5,
      totalTrips: json['totalTrips'] as int? ?? 0,
    );
  }
}

