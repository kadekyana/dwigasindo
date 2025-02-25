import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class WidgetButtonDistribusi extends StatelessWidget {
  final String title;
  final List<Map<String, String>>? dataList;
  final Function(BuildContext context, Map<String, String> data)? onItemTap;
  final Widget? onTap;
  final Future<void> Function(BuildContext context)? onFunction;

  const WidgetButtonDistribusi({
    required this.title,
    required this.dataList,
    this.onItemTap,
    this.onTap,
    this.onFunction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        if (onFunction != null) {
          await onFunction;
        }

        // Show modal
        if (dataList != null) {
          WoltModalSheet.show(
            context: context,
            pageListBuilder: (bottomSheetContext) => [
              SliverWoltModalSheetPage(
                topBarTitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title, style: titleTextBlack),
                ),
                isTopBarLayerAlwaysVisible: true,
                navBarHeight: 60,
                mainContentSliversBuilder: (context) => [
                  SliverList.builder(
                    itemCount: dataList!.length,
                    itemBuilder: (context, index) {
                      final data = dataList![index];
                      return GestureDetector(
                        onTap: () {
                          onItemTap!(context, data);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                            vertical: height * 0.01,
                          ),
                          height: 100,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 3),
                                  color: Colors.grey.shade300),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.centerRight,
                                    image: (data['tipe'] == 'BPTI')
                                        ? const AssetImage(
                                            'assets/images/bpti.png',
                                          )
                                        : const AssetImage(
                                            'assets/images/bptk.png',
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 25,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(data['tipe']!,
                                            style: titleTextBlack),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width,
                                      height: 50,
                                      child: Row(
                                        children: [
                                          if (data['hari'] != '')
                                            const SizedBox(
                                              width: 50,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text('Hari Ini'),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text('100'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (data['hari'] != '')
                                            SizedBox(width: width * 0.05),
                                          const SizedBox(
                                            width: 50,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text('Bulan Ini'),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text('100'),
                                                  ),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 50),
                  ),
                ],
              ),
            ],
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => onTap!),
          );
        }
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
          vertical: height * 0.01,
        ),
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        height: height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 3),
                color: Colors.grey.shade300),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/distribusi.png'),
                ),
              ),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Container(
                height: 25,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(title, style: titleTextBlack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
