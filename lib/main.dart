import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonify_app/constant.dart';
import 'package:toonify_app/screens/splash_screen.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ToonifyApp());
}

double screenWidget = 428;
double screenHeight = 926;

class ToonifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkAndSaveApiKey();
    return ScreenUtilInit(
        designSize: Size(screenWidget, screenHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
        child: SplashScreen()// WelcomeScreen(),

    );
  }
}



Future<void> checkAndSaveApiKey() async {
  // Check if API key is already saved in shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? apiKey = prefs.getString('api_key');

  if (apiKey == null) {
    // API key is not saved, save it to shared preferences
    String newApiKey = API_KEY; // Replace with your API key
    await prefs.setString('api_key', newApiKey);
    print('API key saved to shared preferences: $newApiKey');
  } else {
    // API key is already saved in shared preferences
    print('API key already exists in shared preferences: $apiKey');
  }
}