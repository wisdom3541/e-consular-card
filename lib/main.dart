import 'package:e_consular_card/features/onboarding/presentation/screens/splash_screen_page.dart';
import 'package:e_consular_card/config/injection.dart';
import 'package:e_consular_card/core/data/datasources/location_remote_datasource.dart';
import 'package:e_consular_card/core/navigation/main_navigation.dart';
import 'package:e_consular_card/core/presentation/providers/location_provider.dart';
import 'package:e_consular_card/core/services/storage_service.dart';
import 'package:e_consular_card/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_consular_card/features/auth/presentation/providers/auth_provider.dart';
import 'package:e_consular_card/features/auth/presentation/screens/login_page.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/card_request_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/card_request_provider.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:e_consular_card/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:e_consular_card/features/payments/data/datasources/payment_remote_datasource.dart';
import 'package:e_consular_card/features/payments/presentation/providers/payment_processing_provider.dart';
import 'package:e_consular_card/features/payments/presentation/providers/payment_provider.dart';
import 'package:e_consular_card/features/signature/presentation/providers/signature_provider.dart';
import 'package:e_consular_card/features/support/data/datasources/support_remote_datasource.dart';
import 'package:e_consular_card/features/support/presentation/providers/support_provider.dart';
import 'package:e_consular_card/providers/app_provider.dart';
import 'package:e_consular_card/providers/create_acccount_with_nin_provider.dart';
import 'package:e_consular_card/providers/create_account_without_nin_provider.dart';
import 'package:e_consular_card/providers/loggedIn/cart_provider.dart';
//import 'package:e_consular_card/providers/loggedIn/document_provider.dart';
import 'package:e_consular_card/providers/login_screen_provider.dart';
import 'package:e_consular_card/providers/otp_provider.dart';
import 'package:e_consular_card/providers/register_without_nin_provider.dart';
import 'package:e_consular_card/providers/update_nin_data_provider.dart';
import 'package:e_consular_card/features/auth/presentation/screens/createAccount.dart';
import 'package:e_consular_card/screens/createAccountWithNIN.dart';
import 'package:e_consular_card/screens/documentScreen.dart';
import 'package:e_consular_card/screens/emptyRequestScreen.dart';
import 'package:e_consular_card/screens/enterYourDetails.dart';
import 'package:e_consular_card/screens/homePage.dart';
import 'package:e_consular_card/screens/otpScreen.dart';
import 'package:e_consular_card/screens/payWithCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/signature/data/datasources/segnature_remote_datasource.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensures binding is initialized

// Setup dependency injection
  await setupDependencies();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //   ChangeNotifierProvider(create: (context) => AppProvider()),
        //ChangeNotifierProvider(
        //    create: (context) => CreateAcccountWithNinProvider()),
        ChangeNotifierProvider(
            create: (context) => CreateAccountWithoutNinProvider()),

        //ChangeNotifierProvider(create: (context) => PayWithCardState()),
        // ChangeNotifierProvider(create: (context) => HomePageState()),
        // ChangeNotifierProvider(create: (context)=> DocumentProvider()),
        ChangeNotifierProvider(create: (context) => UpdateNinDataProvider()),
        ChangeNotifierProvider(create: (context) => LoginScreenProvider()),
        //ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(
            create: (context) => RegisterWithoutNinProvider()),

/////////////////////////////
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            authDataSource: getIt<AuthRemoteDataSource>(),
            storageService: getIt<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),

        ChangeNotifierProvider(
          create: (_) => SignatureProvider(
            signatureDataSource: getIt<SignatureRemoteDataSource>(),
          ),
        ),
        // ChangeNotifierProvider(create: (_) => CardRequestProvider()),

        ChangeNotifierProvider(
          create: (_) => PaymentProvider(
            paymentDataSource: getIt<PaymentRemoteDataSource>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => SupportProvider(
            supportDataSource: getIt<SupportRemoteDataSource>(),
          ),
        ),

        // Payment Processing Provider
        ChangeNotifierProvider(
          create: (_) => PaymentProcessingProvider(
            paymentDataSource: getIt<PaymentRemoteDataSource>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => DashboardProvider(
            dashboardDataSource: getIt<DashboardRemoteDataSource>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => CardRequestProvider(
            cardRequestDataSource: getIt<CardRequestRemoteDataSource>(),
          ),
        ),
       

        ChangeNotifierProvider(
          create: (_) => LocationProvider(
            locationDataSource: getIt<LocationRemoteDataSource>(),
          )..loadCountries(), // Auto-load countries on app start
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            title: 'E-DocRequest',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                if (authProvider.isAuthenticated) {
                  return const MainNavigation();
                } else {
                  return const LoginPage();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
