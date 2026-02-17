import 'package:e_consular_card/core/data/datasources/location_remote_datasource.dart';
import 'package:e_consular_card/core/services/storage_service.dart';
import 'package:e_consular_card/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/card_request_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:e_consular_card/features/payments/data/datasources/payment_remote_datasource.dart';
import 'package:e_consular_card/features/signature/data/datasources/segnature_remote_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/api_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Storage Service
  getIt.registerLazySingleton(() => StorageService(getIt()));

  // Core services
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiService(
        getIt<Dio>(),
        storageService: getIt<StorageService>(),
        onUnauthorized: () {
          // Handle token expiration globally
          print('🔒 Token expired - logging out user');
          // You can trigger logout here if needed
        },
      ));

  // Authentication
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: getIt()),
  );
//dashboard
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(apiService: getIt()),
  );

//card request
  getIt.registerLazySingleton<CardRequestRemoteDataSource>(
    () => CardRequestRemoteDataSourceImpl(apiService: getIt()),
  );

  // Signature
  getIt.registerLazySingleton<SignatureRemoteDataSource>(
    () => SignatureRemoteDataSourceImpl(apiService: getIt()),
  );

//payment
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(apiService: getIt()),
  );


  // Location
  getIt.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(apiService: getIt()),
  );
}
