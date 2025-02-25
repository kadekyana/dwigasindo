import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/views/auth/auth_login.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPreferences extends StatelessWidget {
  const MenuPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: WidgetButtonCustom(
        FullWidth: width * 0.8,
        FullHeight: 50,
        title: "Logout",
        onpressed: () async {
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          preferences.clear();
          preferences.remove('username');
          preferences.remove('password');
          preferences.remove('token');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthLogin()),
          );
        },
        color: PRIMARY_COLOR,
        bgColor: PRIMARY_COLOR,
      )),
    );
  }
}
