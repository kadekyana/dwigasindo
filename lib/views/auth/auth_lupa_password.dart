import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
// import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class AuthLupaPassword extends StatelessWidget {
  const AuthLupaPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // inisiasi provider
    // final auth = Provider.of<ProviderAuth>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // form dan info
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                height: 30,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Reset Password',
                                    style: subtitleTextBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                height: 20,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      'Silahkan masukkan email untuk reset password',
                                      style: subtitleTextBlack),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
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
                                      child: const Text('Email'),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                      ),
                                      child: Center(
                                        child: WidgetForm(
                                          typeInput: TextInputType.emailAddress,
                                          alert: 'Masukkan Email',
                                          hint: "Masukkan Email",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      // button masuk
                      Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: WidgetButtonCustom(
                                FullWidth: MediaQuery.of(context).size.width,
                                FullHeight: 50,
                                title: 'Reset Password',
                                onpressed: () {},
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
