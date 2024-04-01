import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/firebase_options.dart';
import 'package:project_namaa/screens/HomeLayout.dart';
import 'package:project_namaa/screens/HomeScreen.dart';
import 'package:project_namaa/screens/SingUp.dart';
import 'package:project_namaa/screens/loginScreen.dart';
import 'package:project_namaa/screens/onboarding_screen.dart';
import 'package:project_namaa/screens/productsCategory.dart';
import 'package:project_namaa/screens/providerCard/CardProvider.dart';
import 'package:project_namaa/screens/providerCard/CardScreen.dart';
import 'package:project_namaa/screens/providerCard/ItemProducts.dart';
import 'package:project_namaa/screens/providerFav/favProvider.dart';
import 'package:project_namaa/screens/splash_screen.dart';
import 'package:project_namaa/shared/Cache_Helper/cache_helper.dart';
import 'package:provider/provider.dart';

int? initscreen = 0;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // initscreen = preferences.getInt('initScreen');
  // await preferences.setInt('initScreen', 1);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderCart()),
        ChangeNotifierProvider(create: (_) => ProviderFav()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 21),
          ),
          fontFamily: 'NotoSerif',
        ),
        title: 'Hand Made Store',

        // initialRoute: '/',
        // initialRoute: initscreen == 0 || initscreen == null ? 'onboard' : 'home',
        routes: {
          '/': (context) => const SplashScreen(),
          // '/': (context) => const UploadImage(),
          '/onboard': (context) => OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/sinup': (context) => const SingUpScreen(),
          '/home': (context) => const HomeLayout(),
          '/homeScreen': (context) => const HomeScreen(),
          '/products Category': (context) => const ProductsCategory(),
          '/Item Product': (context) => const ItemProduct(),
          '/Card Screen': (context) => const CardScreen(),
        },
      ),
    );
  }
}
