import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItemWidget extends StatelessWidget {
  final dynamic
      data; // Sesuaikan tipe data ini sesuai model `provider.so!.data![index]`
  final ProviderItem provider; // Tipe provider sesuai dengan yang Anda gunakan
  final double width;
  final double height;
  final String buttonText;
  final Function? routeNav;
  final bool hideTanggal;
  final bool hideButton;

  const ListItemWidget({
    required this.data,
    required this.provider,
    required this.width,
    required this.height,
    required this.buttonText,
    required this.routeNav,
    this.hideTanggal = false,
    this.hideButton = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.h,
      margin: EdgeInsets.only(bottom: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Color(0xffE4E4E4),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          SizedBox(
            width: double.infinity,
            height: height * 0.045,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      data.no ?? '-', // Misalnya menggunakan `id` dari `data`
                      style: titleText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: WidgetButtonCustom(
                    FullWidth: width * 0.25,
                    FullHeight: 30.h,
                    title: 'Riwayat',
                    onpressed: () {
                      // Anda bisa menggunakan data di sini
                      print('Riwayat data ID: ${data.no}');
                    },
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          // Body
          _buildBody(width, hideTanggal, hideButton, height),
          // Footer
          _buildFooter(width, buttonText, routeNav, height),
        ],
      ),
    );
  }

  Widget _buildBody(
      double width, bool hideTanggal, bool hideButton, double height) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8.w, top: 2.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Tanggal', style: subtitleTextBlack),
                  ),
                  SizedBox(
                    child: Text(
                      ' : ',
                      style: subtitleTextBlack,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      provider.formatDate(data.createdAt
                          .toString()), // Contoh menggunakan `tanggal` dari data
                      style: subtitleTextBlack,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Keterangan',
                      style: subtitleTextBlack,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      ' : ',
                      style: subtitleTextBlack,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('${data.note ?? '-'}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: subtitleTextBlack),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child:
                              Text('Dibuat oleh', style: subtitleTextNormal)),
                    ),
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ' : ',
                        style: subtitleTextNormal,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('${data.createdByName ?? '-'}',
                          overflow: TextOverflow.ellipsis,
                          style: subtitleTextNormal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(
      double width, String buttonText, Function? routeNav, double height) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 8.w, right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hideButton
              ? Expanded(
                  child: WidgetButtonCustom(
                    FullWidth: width * 0.2,
                    FullHeight: height * 0.035,
                    title: 'Berita Acara',
                    onpressed: () {
                      print('Berita Acara: ${data.no}');
                    },
                    bgColor: Colors.green.shade500,
                    color: Colors.transparent,
                  ),
                )
              : const SizedBox.shrink(),
          hideButton
              ? SizedBox(
                  width: 5.w,
                )
              : SizedBox.shrink(),
          Expanded(
            child: WidgetButtonCustom(
              FullWidth: width * 0.2,
              FullHeight: height * 0.035,
              title: buttonText,
              onpressed: routeNav!,
              bgColor: PRIMARY_COLOR,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
