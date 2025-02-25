import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/views/auth/auth_lupa_password.dart';
// import 'package:dwigasindo/views/menus/menu_home.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
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
            ? const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
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
                                    const SizedBox(
                                      width: double.maxFinite,
                                      height: 30,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Selamat Datang',
                                          style: TextStyle(
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: double.maxFinite,
                                      height: 20,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Silahkan login untuk masuk ke aplikasi ini',
                                          style: TextStyle(
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w300),
                                        ),
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
                                          const SizedBox(
                                            width: double.maxFinite,
                                            height: 20,
                                            child: Text('Username'),
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
                                          const SizedBox(
                                            width: double.maxFinite,
                                            height: 20,
                                            child: Text('Password'),
                                          ),
                                          Consumer<ProviderAuth>(
                                            builder: (BuildContext context,
                                                value, Widget? child) {
                                              return Container(
                                                width: double.maxFinite,
                                                height: 60,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                ),
                                                child: Center(
                                                  child: WidgetForm(
                                                    controller: auth.password,
                                                    typeInput:
                                                        TextInputType.text,
                                                    alert: 'Masukkan Password',
                                                    hint: "Masukkan Password",
                                                    border: InputBorder.none,
                                                    suicon: IconButton(
                                                      onPressed: () {
                                                        auth.toggleVisible();
                                                      },
                                                      icon: auth.visible.value
                                                          ? const Icon(Icons
                                                              .visibility_off)
                                                          : const Icon(
                                                              Icons.visibility),
                                                    ),
                                                    obscure:
                                                        !auth.visible.value,
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
                                                    const AuthLupaPassword(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Lupa Password',
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontFamily: "Manrope"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                )),
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
                                        auth.tesApi();
                                        await auth.login(auth.username.text,
                                            auth.password.text, context);
                                      },
                                      bgColor: PRIMARY_COLOR,
                                      color: Colors.transparent),
                                )),
                          ],
                        )),
                    Expanded(child: Container()),
                  ],
                ),
              ));
  }
}
