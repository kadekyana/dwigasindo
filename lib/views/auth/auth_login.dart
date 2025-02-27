import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/views/auth/auth_lupa_password.dart';
import 'package:dwigasindo/views/menus/menu_dashboard.dart';
// import 'package:dwigasindo/views/menus/menu_home.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    // inisiasi provider
    final auth = Provider.of<ProviderAuth>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: (auth.isLoading == true)
            ? Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          // form dan info
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 30,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Selamat Datang',
                                      style: superTitleTextBlack,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 20,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Silahkan login untuk masuk ke aplikasi ini',
                                        style: titleTextBlack),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 90,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: double.maxFinite,
                                        height: 20,
                                        child: Text(
                                          'Username',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 60,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                        ),
                                        child: Center(
                                          child: WidgetForm(
                                            controller: auth.username,
                                            typeInput: TextInputType.text,
                                            alert: 'Masukkan Username',
                                            hint: "Masukkan Username",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 90,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: double.maxFinite,
                                        height: 20,
                                        child: Text(
                                          'Password',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                      Consumer<ProviderAuth>(
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return Container(
                                            width: double.maxFinite,
                                            height: 60,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey.shade400),
                                            ),
                                            child: Center(
                                              child: WidgetForm(
                                                controller: auth.password,
                                                typeInput: TextInputType.text,
                                                alert: 'Masukkan Password',
                                                hint: "Masukkan Password",
                                                border: InputBorder.none,
                                                suicon: IconButton(
                                                  onPressed: () {
                                                    auth.toggleVisible();
                                                  },
                                                  icon: auth.visible.value
                                                      ? const Icon(
                                                          Icons.visibility_off)
                                                      : const Icon(
                                                          Icons.visibility),
                                                ),
                                                obscure: !auth.visible.value,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 50,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AuthLupaPassword(),
                                          ),
                                        );
                                      },
                                      child: Text('Lupa Password',
                                          style: subtitleTextNormal),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          // button masuk
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: WidgetButtonCustom(
                                    FullWidth:
                                        MediaQuery.of(context).size.width,
                                    FullHeight: 50,
                                    title: 'Masuk',
                                    onpressed: () async {
                                      await auth.login(auth.username.text,
                                          auth.password.text, context);
                                    },
                                    bgColor: PRIMARY_COLOR,
                                    color: Colors.transparent),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
