import 'package:dwigasindo/const/const_color.dart';
import 'package:flutter/material.dart';

class WidgetAppbar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetAppbar({
    super.key,
    required this.title,
    this.back = false,
    this.center = false,
    this.route,
    this.actions,
    this.customHeight,
    this.colorBG,
    this.colorTitle,
    this.sizefont,
    this.colorBack,
    this.extraWidget, // Widget tambahan seperti search bar atau filter
  });

  final String title;
  final bool back;
  final Color? colorBack;
  final Color? colorBG;
  final Color? colorTitle;
  final bool center;
  final List<Widget>? actions;
  final Function()? route;
  final double? sizefont;
  final double? customHeight; // Tinggi AppBar kustom
  final Widget? extraWidget; // Widget tambahan

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme:
          IconThemeData(color: (colorBack != null) ? colorBack : Colors.white),
      leading: back
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: route,
            )
          : null,
      centerTitle: center,
      // ignore: unnecessary_null_comparison
      backgroundColor: (colorBG != null) ? colorBG : PRIMARY_COLOR,
      title: Text(
        title,
        style: TextStyle(
            fontSize: (sizefont != null) ? sizefont : 20,
            color: (colorTitle != null) ? colorTitle : Colors.white,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700),
      ),
      actions: actions,
      bottom: extraWidget != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(customHeight ?? kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: extraWidget,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(customHeight ??
      kToolbarHeight +
          (extraWidget != null ? (customHeight ?? kToolbarHeight) : 0));
}
