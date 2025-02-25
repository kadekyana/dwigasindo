import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/main.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/views/auth/auth_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuSplashScreen extends StatefulWidget {
  MenuSplashScreen({super.key});

  @override
  State<MenuSplashScreen> createState() => _MenuSplashScreenState();
}

class _MenuSplashScreenState extends State<MenuSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final provider = Provider.of<ProviderAuth>(context, listen: false);
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final username = preferences.getString('username');
    final password = preferences.getString('password');

    await Future.delayed(Duration(seconds: 2)); // Delay agar logo bisa terlihat

    if (mounted) {
      if (username != null && password != null) {
        bool loginSuccess = await provider.login(username, password, context);
        if (!loginSuccess) {
          _navigateToLogin();
        }
      } else {
        _navigateToLogin();
      }
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AuthLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: PRIMARY_COLOR,
        onInit: () => debugPrint("On Init"),
        onEnd: () => debugPrint("On End"),
        childWidget: Image.asset("assets/images/logoSplash.png"),
        onAnimationEnd: () => debugPrint("On Fade In End"),
      ),
    );
  }
}
