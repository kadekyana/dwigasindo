import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/views/auth/auth_login.dart';
import 'package:dwigasindo/views/menus/menu_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuSplashScreen extends StatefulWidget {
  const MenuSplashScreen({super.key});

  @override
  State<MenuSplashScreen> createState() => _MenuSplashScreenState();
}

class _MenuSplashScreenState extends State<MenuSplashScreen> {
  bool isUser = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAuth>(context);
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: PRIMARY_COLOR,
        onInit: () async {
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          final username = preferences.getString('username');
          final password = preferences.getString('password');
          if (username != null && password != null) {
            bool data = await provider.login(username, password, context);
            print(data);
            if (data == true) {
              isUser = true;
            } else {
              isUser = false;
            }
          }
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: Image.asset("assets/images/logoSplash.png"),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen:
            (isUser == true) ? const MenuDashboard() : const AuthLogin(),
      ),
    );
  }
}
