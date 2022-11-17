import 'package:fast_fueler_mobile_station/common/widgets/bottom_bar.dart';
import 'package:fast_fueler_mobile_station/common/widgets/home_loading.dart';
import 'package:fast_fueler_mobile_station/providers/user_provider.dart';
import 'package:fast_fueler_mobile_station/router.dart';
import 'package:fast_fueler_mobile_station/screens/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/signin_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  bool homeLoaded = false;

  @override
  void initState() {
    print("starting point");
    super.initState();
    getData();
  }

  void getData() async {
    var a = await authService.getUserData(context);
    setState(() {
      homeLoaded = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Fueler Station',
      onGenerateRoute: (settings) => generateRoute(settings),
      home: homeLoaded
          ? (Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? BottomBar()
              : SigninScreen())
          : HomeLoading(),
    );
  }
}
