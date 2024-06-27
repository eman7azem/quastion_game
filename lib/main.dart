import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/presentation/screens/register/sign_up.dart';
import 'bottom_bar/bottom_bar.dart';
import 'constants/colors.dart';
import 'presentation/screens/login/signin.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
        enabled: true, builder: (context) => const MyApp() // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Login.routeName,
        routes: {
          BottomNavBar.routeName: (context) => BottomNavBar(),
          SignUp.routeName: (context) => const SignUp(),
          Login.routeName: (context) =>  Login(),
        },
      ),
    );
  }
}
