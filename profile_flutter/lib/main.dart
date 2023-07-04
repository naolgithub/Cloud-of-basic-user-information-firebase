import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_flutter/models/client_user.dart';
import 'package:profile_flutter/providers/user_provider.dart';
import 'package:profile_flutter/utils/color.dart';
import 'package:profile_flutter/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'resources/another_auth_methods.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Profile',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          // titleTextStyle: const TextStyle(
          //   color: primaryColor,
          //   fontSize: 20,
          //   fontWeight: FontWeight.w600,
          //   fontStyle: FontStyle.italic,
          // ),
          titleTextStyle: GoogleFonts.satisfy(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          iconColor: Colors.white,
          outlineBorder: BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.black,
          ),
        ),
        // platform: TargetPlatform.macOS,
        // platform: TargetPlatform.linux,
        // platform: TargetPlatform.android,
        //  platform: TargetPlatform.iOS,
        // platform: TargetPlatform.windows,
        // primaryTextTheme: const TextTheme(
        //   displayLarge: TextStyle(
        //     fontSize: 20,
        //     fontStyle: FontStyle.italic,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   displayMedium: TextStyle(
        //     fontSize: 20,
        //     fontStyle: FontStyle.italic,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   displaySmall: TextStyle(
        //     fontSize: 20,
        //     fontStyle: FontStyle.italic,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        primaryTextTheme: GoogleFonts.satisfyTextTheme(
          const TextTheme(
            // bodyLarge: TextStyle(
            //   fontSize: 25,
            //   fontStyle: FontStyle.italic,
            //   fontWeight: FontWeight.bold,
            // ),
            bodyMedium: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            // bodySmall: TextStyle(
            //   fontSize: 25,
            //   fontStyle: FontStyle.italic,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
        ),
      ),
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      //user persisting user provider.
      home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(FirebaseAuth.instance.currentUser != null
                  ? FirebaseAuth.instance.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(ClientUser.fromMap(value));
            }
            return value;
          }),
          //Here the snapshot parameter will get the value returned
          //from then function and user data will be persisted.
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const OnboardingScreen();
          }),
    );
  }
}
