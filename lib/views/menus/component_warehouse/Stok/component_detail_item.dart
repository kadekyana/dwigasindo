import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComponentDetailItem extends StatefulWidget {
  ComponentDetailItem({super.key});

  @override
  _ComponentDetailItemState createState() => _ComponentDetailItemState();
}

class _ComponentDetailItemState extends State<ComponentDetailItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    final data = provider.detailItem?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Detail Item",
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        back: true,
        center: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 150.w,
            height: 100.h,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage("$pathUrl/${data?.photo}"),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Nama',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(data?.name ?? "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Code',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(data?.code ?? "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Kategori',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            '${data?.categoryId.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Unit',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            '${data?.unitId.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Harga',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            (data?.price != null)
                                                ? providerSales.formatCurrency(
                                                    data?.price as num)
                                                : "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Limit Stok',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            '${data?.limitStock ?? "-"}',
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Vendor',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(data?.vendorName ?? "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Apakah Item Dijual Kembali ?',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            (data?.isItemSell == 1)
                                                ? "Tidak"
                                                : "Iya",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Harga Jual',
                                            style: subtitleTextNormalblack,
                                          ),
                                        ),
                                      ),
                                      const Text(':\t'),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            (data?.isItemSell == 1)
                                                ? "-"
                                                : (data?.sellPrice != null)
                                                    ? providerSales
                                                        .formatCurrency(
                                                            data!.sellPrice)
                                                    : "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalblack),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   child: Row(
                                //     children: [
                                //       Expanded(
                                //         flex: 2,
                                //         child: FittedBox(
                                //           fit: BoxFit.scaleDown,
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             'Harga',
                                //             style: subtitleTextNormalblack,
                                //           ),
                                //         ),
                                //       ),
                                //       const Text(':'),
                                //       Expanded(
                                //         flex: 3,
                                //         child: Text('Rp. 100.000.000',
                                //             overflow: TextOverflow.ellipsis,
                                //             style: subtitleTextNormalblack),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Expanded(
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Expanded(
                                //         flex: 2,
                                //         child: FittedBox(
                                //           fit: BoxFit.scaleDown,
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             'Garansi',
                                //             style: subtitleTextNormalblack,
                                //           ),
                                //         ),
                                //       ),
                                //       const Text(':'),
                                //       Expanded(
                                //         flex: 3,
                                //         child: Text('\t2 Bulan',
                                //             overflow: TextOverflow.ellipsis,
                                //             style: subtitleTextNormalblack),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Expanded(
                                //   child: Row(
                                //     children: [
                                //       Expanded(
                                //         flex: 2,
                                //         child: FittedBox(
                                //           fit: BoxFit.scaleDown,
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             'Deskripsi',
                                //             style: subtitleTextNormalblack,
                                //           ),
                                //         ),
                                //       ),
                                //       const Text(':'),
                                //       Expanded(
                                //         flex: 3,
                                //         child: Text('\tLorem Ipsum',
                                //             overflow: TextOverflow.ellipsis,
                                //             style: subtitleTextNormalblack),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Dibuat Pada',
                                            style: subtitleTextNormalGrey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ':\t',
                                        style: subtitleTextNormalGrey,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            provider.formatDate(
                                                data!.createdAt.toString()),
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Dibuat Oleh',
                                            style: subtitleTextNormalGrey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ':\t',
                                        style: subtitleTextNormalGrey,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(data.createdByName ?? "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextNormalGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
