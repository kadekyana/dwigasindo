import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelDetailKunjungan.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/location.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/widget_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline_list.dart';

class ComponentTugas extends StatefulWidget {
  ComponentTugas({super.key, required this.title});
  String title;

  @override
  State<ComponentTugas> createState() => _ComponentDataMasterCustomerState();
}

class _ComponentDataMasterCustomerState extends State<ComponentTugas> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.kunjungan?.data;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.1,
              child: Row(
                children: [
                  // Search bar
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: WidgetForm(
                        alert: 'Search',
                        hint: 'Search',
                        border: InputBorder.none,
                        preicon: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  // filter bar
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            (data == null)
                ? const Expanded(
                    child: Center(
                      child: Text("Belum Terdapat Data"),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final dataCard = data[index];
                        return Container(
                          width: double.maxFinite,
                          height: 200.h,
                          margin: EdgeInsets.only(bottom: 10.h),
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
                              SizedBox(
                                width: double.maxFinite,
                                height: height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.3,
                                      height: height * 0.05,
                                      decoration: const BoxDecoration(
                                        color: PRIMARY_COLOR,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      // "type_visiting":1,// 1 = Prospek, 2 = Exising Customer, 3 = Komplain, 4 = Claim
                                      child: Center(
                                        child: Text(
                                          ((dataCard.typeVisiting == null)
                                              ? "-"
                                              : (dataCard.typeVisiting == 1)
                                                  ? "Prospek"
                                                  : (dataCard.typeVisiting == 2)
                                                      ? "Existing"
                                                      : (dataCard.typeVisiting ==
                                                              3)
                                                          ? "Komplain"
                                                          : "Claim"),
                                          style: titleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.3,
                                      height: height * 0.05,
                                      decoration: BoxDecoration(
                                        color: (data == true)
                                            ? COMPLEMENTARY_COLOR2
                                            : Colors.grey.shade500,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (data == true)
                                              ? "Approve"
                                              : "Menunggu",
                                          style: titleText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.025, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Nama Karyawan',
                                                      style: subtitleTextBlack,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Text(' : ',
                                                        style:
                                                            subtitleTextBlack),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '${dataCard.leadName ?? "-"}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextBlack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/approve2.svg',
                                                    width: 30.w,
                                                    height: 20.h,
                                                  ),
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  (data == true)
                                                      ? SvgPicture.asset(
                                                          'assets/images/approve3.svg',
                                                          width: 20.w,
                                                          height: 20.h,
                                                        )
                                                      : SvgPicture.asset(
                                                          'assets/images/approve1.svg',
                                                          width: 20.w,
                                                          height: 20.h,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Nama Customer',
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
                                              child: Text(
                                                '${dataCard.customerName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.start,
                                      //     children: [
                                      //       Expanded(
                                      //         flex: 2,
                                      //         child: Text(
                                      //           'Tanggal dan Jam',
                                      //           style: subtitleTextBlack,
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         child: Text(
                                      //           ' : ',
                                      //           style: subtitleTextBlack,
                                      //         ),
                                      //       ),
                                      //       Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //             '07 - 12 - 2024 09:30',
                                      //             style: subtitleTextBlack),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Lokasi',
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
                                              child: Text(
                                                  '${dataCard.location}',
                                                  style: subtitleTextBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Dibuat Oleh',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text('User 1',
                                                  style: subtitleTextNormal),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Dibuat Pada',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatDate(dataCard
                                                      .createdAt
                                                      .toString()),
                                                  style: subtitleTextNormal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10.h, left: 10.w, right: 10.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: WidgetButtonCustom(
                                        FullWidth: width * 0.3,
                                        FullHeight: 30.h,
                                        title: "Lihat Tugas",
                                        onpressed: () async {
                                          if (!mounted) {
                                            return
                                                // Tampilkan Dialog Loading
                                                showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            );
                                          }

                                          try {
                                            await Future.wait([
                                              provider.getDetailKungan(
                                                  context, dataCard.id!),
                                            ]);

                                            // Navigate sesuai kondisi
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentDetailTugas(
                                                  id: dataCard.id!,
                                                ),
                                              ),
                                            );
                                          } catch (e) {
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            print('Error: $e');
                                            // Tambahkan pesan error jika perlu
                                          }
                                        },
                                        bgColor: PRIMARY_COLOR,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ComponentDetailTugas extends StatefulWidget {
  ComponentDetailTugas({
    super.key,
    required this.id,
  });
  int id;
  @override
  State<ComponentDetailTugas> createState() => _ComponentDetailTugasState();
}

class _ComponentDetailTugasState extends State<ComponentDetailTugas> {
  bool isExpanded = false;
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool selectButton = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.detailKunjugan?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Detail Tugas",
        colorBG: Colors.grey.shade100,
        center: true,
        back: true,
        colorBack: Colors.black,
        route: () {
          Navigator.pop(context);
        },
        colorTitle: Colors.black,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: 5.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Nama Karyawam',
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
                            child: Text(
                              data?.name ?? "-",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: subtitleTextBlack,
                            ),
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
                            child: Text(
                              'Nama Customer',
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
                            child: Text(
                              data?.customer ?? "-",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: subtitleTextBlack,
                            ),
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
                            child: Text(
                              'Lokasi',
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
                            child: Text(data?.location ?? "-",
                                style: subtitleTextBlack),
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
                            child: Text(
                              'Jenis Tugas',
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
                            child: Text(
                                ((data?.typeVisiting == null)
                                    ? "-"
                                    : (data!.typeVisiting == 1)
                                        ? "Prospek"
                                        : (data.typeVisiting == 2)
                                            ? "Existing"
                                            : (data.typeVisiting == 3)
                                                ? "Komplain"
                                                : "Claim"),
                                style: subtitleTextBlack),
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
                            child: Text(
                              'Tanggal dan Jam',
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
                            child: Text('07 - 12 - 2024 09:30',
                                style: subtitleTextBlack),
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
                            child: Text(
                              'Catatan',
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
                            child: Text("${data?.note ?? "-"} ",
                                overflow: TextOverflow.ellipsis,
                                style: subtitleTextBlack),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              width: width,
              height: height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: 40.h,
                      title: "Tambah Tugas",
                      onpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TambahTugas(
                              id: widget.id,
                            ),
                          ),
                        );
                      },
                      color: PRIMARY_COLOR,
                      bgColor: PRIMARY_COLOR,
                    ),
                    // Timeline list
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Timeline.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          markerBuilder: (context, index) =>
                              _buildTimelineItem(data!.histories![index]),
                          context: context,
                          markerCount: isExpanded ? data!.histories!.length : 1,
                          properties: TimelineProperties(
                            markerGap: 0.h,
                            iconSize: 10.w,
                            timelinePosition: TimelinePosition.start,
                          )),
                    ),

                    // Tombol Expand/Collapse
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                        label: Text(isExpanded ? 'Tutup' : 'Lihat Semua'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    /// Membuat item timeline untuk setiap data
  }

  Marker _buildTimelineItem(History? item) {
    final provider = Provider.of<ProviderSales>(context);
    return Marker(
      child: Container(
        width: 300.w,
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h, top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: PRIMARY_COLOR),
              child: Center(
                  // "task_type":1,  // 1 = check in, 2 = catatan, 3 = check out, 4 = disposisi
                  child: Text(
                      ((item!.type == null)
                          ? "-"
                          : (item.type == 1)
                              ? "Check In"
                              : (item.type == 2)
                                  ? "Catatan"
                                  : (item.type == 3)
                                      ? "Check Out"
                                      : "Disposisi"),
                      style: subtitleTextBold)),
            ),
            SizedBox(height: 4.h),
            Text(
              '${provider.formatDate(item.updatedAt.toString())} | ${provider.formatTime(item.updatedAt.toString())}',
              style: subtitleTextNormalGrey,
            ),
            SizedBox(height: 4.h),
            if (item.type != 1 || item.type != 3)
              Text(
                item.note ?? "-",
                textAlign: TextAlign.justify,
                style: subtitleTextNormalblack,
              ),
            if (item.type == 1 || item.type == 3)
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackingPage(
                                  latitude: item.lat!,
                                  longitude: item.long!,
                                )));
                  },
                  child: const Text("TrackingPage")),
          ],
        ),
      ),
    );
  }
}

class TambahTugas extends StatefulWidget {
  TambahTugas({super.key, required this.id});
  int id;
  @override
  State<TambahTugas> createState() => _TambahTugasState();
}

class _TambahTugasState extends State<TambahTugas> {
  quill.QuillController? controller;
  int selectId = 0;
  GroupButtonController? tugas = GroupButtonController(selectedIndex: 0);
  TextEditingController lang = TextEditingController();
  TextEditingController long = TextEditingController();

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Ambil lokasi saat halaman dibuka
    controller = quill.QuillController.basic(); // Inisialisasi controller
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    setState(() {
      lang.text = position.latitude.toString();
      long.text = position.longitude.toString();
    });

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  // Ambil lokasi saat ini

  LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Tambah Tugas",
        center: true,
        colorBG: Colors.grey.shade100,
        back: true,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Pilih Tugas"),
                ),
                subtitle: GroupButton(
                    isRadio: true,
                    controller: tugas,
                    options: GroupButtonOptions(
                      buttonWidth: 150.w,
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                      setState(() {
                        selectId = index;
                      });
                    },
                    buttons: const [
                      'Check In',
                      "Catatan",
                      "Check Out",
                      "Disposisi"
                    ]),
              ),
            ),
            if (selectId == 0 || selectId == 2)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  title: Text(
                    'Longitude (Terisi Otomatis)',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: WidgetForm(
                      enable: false,
                      controller: long,
                      alert: 'Longitude',
                      hint: 'Longitude',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            if (selectId == 0 || selectId == 2)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  title: Text(
                    'Langitude (Terisi Otomatis)',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: WidgetForm(
                      enable: false,
                      controller: lang,
                      alert: 'Langitude',
                      hint: 'Langitude',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            if (selectId == 1 || selectId == 3)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250.h,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 16.w, right: 20.w),
                  title: Text(
                    'Catatan',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: NoteForm(controller: controller!)),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20.w),
        height: 40.h,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: MediaQuery.of(context).size.width,
              FullHeight: 40.h,
              title: 'Simpan',
              onpressed: () async {
                String note = controller!.document.toPlainText();
                if (selectId == 1 || selectId == 3) {
                  await provider.createTugas(
                      context, widget.id, selectId + 1, 0.0, 0.0, note);
                } else {
                  await provider.createTugas(context, widget.id, selectId + 1,
                      double.parse(long.text), double.parse(lang.text), note);
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
