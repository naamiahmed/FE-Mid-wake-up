import 'package:flutter/material.dart';
import '../models/settings_model.dart';
import '../services/storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  AppSettings _settings = AppSettings();
  bool _isLoading = false;

  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;

  SettingsViewModel() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _isLoading = true;
    notifyListeners();

    _settings = await _storageService.getSettings();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateAlarmEnabled(bool value) async {
    _settings = _settings.copyWith(isAlarmEnabled: value);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateRouteDeviationAlerts(bool value) async {
    _settings = _settings.copyWith(isRouteDeviationAlertsEnabled: value);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateAlarmMinutes(int minutes) async {
    _settings = _settings.copyWith(alarmMinutesBeforeArrival: minutes);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateDarkMode(bool value) async {
    _settings = _settings.copyWith(isDarkMode: value);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> markOnboardingComplete() async {
    _settings = _settings.copyWith(hasCompletedOnboarding: true);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> markPermissionsGranted() async {
    _settings = _settings.copyWith(hasGrantedPermissions: true);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }
}

