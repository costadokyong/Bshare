import 'package:bshare/LifeCycle/services/background_fetch_service.dart';
import 'package:bshare/LifeCycle/services/location_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => BackgroundService());
}
