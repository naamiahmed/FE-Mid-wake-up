class AppSettings {
  final bool isAlarmEnabled;
  final bool isRouteDeviationAlertsEnabled;
  final int alarmMinutesBeforeArrival;
  final bool isDarkMode;
  final bool hasCompletedOnboarding;
  final bool hasGrantedPermissions;

  AppSettings({
    this.isAlarmEnabled = false,
    this.isRouteDeviationAlertsEnabled = true,
    this.alarmMinutesBeforeArrival = 10,
    this.isDarkMode = false,
    this.hasCompletedOnboarding = false,
    this.hasGrantedPermissions = false,
  });

  AppSettings copyWith({
    bool? isAlarmEnabled,
    bool? isRouteDeviationAlertsEnabled,
    int? alarmMinutesBeforeArrival,
    bool? isDarkMode,
    bool? hasCompletedOnboarding,
    bool? hasGrantedPermissions,
  }) {
    return AppSettings(
      isAlarmEnabled: isAlarmEnabled ?? this.isAlarmEnabled,
      isRouteDeviationAlertsEnabled: isRouteDeviationAlertsEnabled ?? this.isRouteDeviationAlertsEnabled,
      alarmMinutesBeforeArrival: alarmMinutesBeforeArrival ?? this.alarmMinutesBeforeArrival,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      hasGrantedPermissions: hasGrantedPermissions ?? this.hasGrantedPermissions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAlarmEnabled': isAlarmEnabled,
      'isRouteDeviationAlertsEnabled': isRouteDeviationAlertsEnabled,
      'alarmMinutesBeforeArrival': alarmMinutesBeforeArrival,
      'isDarkMode': isDarkMode,
      'hasCompletedOnboarding': hasCompletedOnboarding,
      'hasGrantedPermissions': hasGrantedPermissions,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isAlarmEnabled: json['isAlarmEnabled'] as bool? ?? false,
      isRouteDeviationAlertsEnabled: json['isRouteDeviationAlertsEnabled'] as bool? ?? true,
      alarmMinutesBeforeArrival: json['alarmMinutesBeforeArrival'] as int? ?? 10,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      hasGrantedPermissions: json['hasGrantedPermissions'] as bool? ?? false,
    );
  }
}

