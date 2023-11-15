import 'package:flutter/material.dart';
import 'package:projet_camping_evenement/events/ShowEvents/participated_events.dart';
import 'package:provider/provider.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'user_provider.dart'; // Import your user_provider.dart file
import 'user/login.dart';
import 'user/signup.dart';
import 'navigations/nav_bottom.dart';
import 'events/ShowEvents/events.dart';
import 'events/ShowEvents/my_events.dart';
import 'events/add_event.dart';
import 'shop/CampingMaterial.dart';
import 'shop/add_CampingMaterial.dart';
import 'shop/my_camping_material.dart';
import 'user/profile_settings.dart';
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/theme3.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson);

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(
        theme: theme,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeData? theme;
  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camping',
      theme: theme,
      routes: {
        "/": (BuildContext context) => const LogIn(),
        "/signup": (BuildContext context) => const SignUp(),
        "/home": (BuildContext context) => const NavBottom(),
        "/events": (BuildContext context) => const Events(),
        "/add_event": (BuildContext context) => const AddEvent(),
        "/my_events": (BuildContext context) => const MyEvents(),
        "/settings": (BuildContext context) => const ProfileSettings(),
        "/shop": (BuildContext context) => const CampingMaterial(),
        "/my_shop": (BuildContext context) => const MyShop(),
        "/shop/add": (BuildContext context) => const AddCampingMaterial(),
        "/events/followed": (BuildContext context) => const ParticipatedEvents()
      },
    );
  }
}
