
import 'package:inri_driver/native/background_location.dart';
import 'package:inri_driver/repositories/background_location_repositories.dart';

class BackgroundLocationRepositoryImpl implements BackgroundLocationRepository {
  final BackgroundLocation _backgroundLocation;

  BackgroundLocationRepositoryImpl(this._backgroundLocation);
  
  @override
  Future<void> startForegroundService() {
  return _backgroundLocation.startForegroundService(); 
  }

  @override
  Future<void> stopForegroundService() {
    return _backgroundLocation.stopForegroundService();
  }
 
}


