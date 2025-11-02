import '../models/user_model.dart';
import 'storage_service.dart';

class AuthService {
  final StorageService _storageService = StorageService();

  Future<UserModel?> signIn(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any credentials
    final user = UserModel(
      id: '1',
      fullName: 'John Doe',
      email: email,
      isPremium: false,
      remainingTrips: 5,
      totalTrips: 0,
    );
    
    await _storageService.saveUser(user);
    return user;
  }

  Future<UserModel?> signUp(String fullName, String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      email: email,
      isPremium: false,
      remainingTrips: 5,
      totalTrips: 0,
    );
    
    await _storageService.saveUser(user);
    return user;
  }

  Future<void> signOut() async {
    await _storageService.removeUser();
  }

  Future<UserModel?> getCurrentUser() async {
    return await _storageService.getUser();
  }

  Future<bool> isAuthenticated() async {
    return await _storageService.isLoggedIn();
  }
}

