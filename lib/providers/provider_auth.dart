import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/main.dart';
import 'package:dwigasindo/model/modelAuth.dart';
import 'package:dwigasindo/views/auth/auth_login.dart';
import 'package:dwigasindo/views/menus/menu_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProviderAuth extends ChangeNotifier {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final dio = Dio();
  bool isLoading = false;
  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  ModelAuth? _auth;

  ModelAuth? get auth => _auth;

  void toggleVisible() {
    visible.value = !visible.value;
    notifyListeners();
  }

  Future<bool> login(
      String username, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    bool data = await loginService(username, password, context);
    if (data == true) {
      Navigator.pushReplacement(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => MenuDashboard(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => AuthLogin(),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
    return data;
  }

  Future<bool> loginService(
      String user, String pass, BuildContext context) async {
    try {
      final response = await dio.post(
        "$baseUrl/login",
        data: {"username": user, "password": pass},
      );
      final data = ModelAuth.fromJson(response.data);
      _auth = data;
      notifyListeners();

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('username', data.data.username);
      preferences.setString('password', pass);
      preferences.setString('token', data.data.accessToken);

      // Gunakan context dari navigatorKey untuk Overlay
      showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Login Berhasil',
        ),
      );

      username.clear();
      password.clear();
      isLoading = false;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Password salah , Silahkan coba kembali',
        ),
      );
      return false;
    }
  }
}
