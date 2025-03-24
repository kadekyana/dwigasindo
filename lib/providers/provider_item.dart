import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelAllCategory.dart';
import 'package:dwigasindo/model/modelAllItem.dart';
import 'package:dwigasindo/model/modelAllLocation.dart';
import 'package:dwigasindo/model/modelAllOrder.dart';
import 'package:dwigasindo/model/modelAllSO.dart';
import 'package:dwigasindo/model/modelAllUnit.dart';
import 'package:dwigasindo/model/modelAllVendor.dart';
import 'package:dwigasindo/model/modelAllWarehouse.dart';
import 'package:dwigasindo/model/modelApprovalVerifikasi.dart';
import 'package:dwigasindo/model/modelCity.dart';
import 'package:dwigasindo/model/modelDataBPTI.dart';
import 'package:dwigasindo/model/modelDetailItem.dart';
import 'package:dwigasindo/model/modelDetailPenerimaanBarang.dart';
import 'package:dwigasindo/model/modelDetailPurchase.dart';
import 'package:dwigasindo/model/modelDetailSPB.dart';
import 'package:dwigasindo/model/modelDetailStock.dart';
import 'package:dwigasindo/model/modelDetaillPO.dart';
import 'package:dwigasindo/model/modelLihatSO.dart';
import 'package:dwigasindo/model/modelMutasi.dart';
import 'package:dwigasindo/model/modelPO.dart';
import 'package:dwigasindo/model/modelPenerimaanBarang.dart';
import 'package:dwigasindo/model/modelSpb.dart';
import 'package:dwigasindo/model/modelSupplier.dart';
import 'package:dwigasindo/model/modelVendorCategory.dart';
import 'package:dwigasindo/views/menus/component_warehouse/So/component_selesai_so.dart';
import 'package:dwigasindo/views/menus/component_warehouse/So/component_stok_opname.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'provider_auth.dart';

class ProviderItem extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = false;
  int cekLoad = 0;
  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  ModelAllItem? _allItem;

  ModelAllItem? get allItem => _allItem;

  // tube grade
  ModelAllCategory? _allCategory;
  ModelAllCategory? get allcategory => _allCategory;

  ModelAllLocation? _location;
  ModelAllLocation? get location => _location;

  ModelAllUnit? _allUnit;
  ModelAllUnit? get units => _allUnit;

  ModelSupplier? _supplier;
  ModelSupplier? get supplier => _supplier;

  ModelAllWarehouse? _warehouse;
  ModelAllWarehouse? get warehouse => _warehouse;

  ModelMutasi? _mutasi;
  ModelMutasi? get mutasi => _mutasi;

  ModelAllSo? _so;
  ModelAllSo? get so => _so;

  ModelSpb? _spb;
  ModelSpb? get spb => _spb;

  ModelPo? _po;
  ModelPo? get po => _po;

  ModelLihatSo? _lihatSo;

  ModelLihatSo? get lihatSo => _lihatSo;

  ModelDetailStock? _detailStock;

  ModelDetailStock? get detailStock => _detailStock;

  ModelApprovalVerifikasi? _approvalVerifikasi;
  ModelApprovalVerifikasi? get approvalVerifikasi => _approvalVerifikasi;

  ModelDetailSpb? _detailSpb;
  ModelDetailSpb? get detailSpb => _detailSpb;

  ModelPenerimaanBarang? _modelPenerimaanBarang;
  ModelPenerimaanBarang? get modelPenerimaanBarang => _modelPenerimaanBarang;

  ModeldetailPenerimaanBarang? _modeldetailPenerimaanBarang;
  ModeldetailPenerimaanBarang? get modeldetailPenerimaanBarang =>
      _modeldetailPenerimaanBarang;

  ModelDataBpti? _modelDataBpti;
  ModelDataBpti? get modelDataBpti => _modelDataBpti;

  ModelAllOrder? _order;

  ModelAllOrder? get order => _order;

  ModelVendorCategory? _modelVendorCategory;
  ModelVendorCategory? get modelVendorCategory => _modelVendorCategory;

  ModelCity? _modelCity;
  ModelCity? get modelCity => _modelCity;

  ModelAllVendor? _vendors;
  ModelAllVendor? get vendors => _vendors;

  ModelDataPo? _dataPo;
  ModelDataPo? get dataPO => _dataPo;

  ModelDetailPurchase? _detailPurchase;
  ModelDetailPurchase? get detailPurchase => _detailPurchase;

  ModelDetailItem? _detailItem;
  ModelDetailItem? get detailItem => _detailItem;

  Future<void> getDetailItem(BuildContext context, String uuid) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "items/$uuid", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDetailItem.fromJson(response!.data);
      _detailItem = data;
      notifyListeners();
    }
  }

  Future<void> getDataVendor(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "vendors", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelAllVendor.fromJson(response!.data);
      _vendors = data;
      notifyListeners();
    }
  }

  Future<void> getDetailPO(BuildContext context, String noPO) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "receiving_orders/$noPO", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDataPo.fromJson(response!.data);
      _dataPo = data;
      notifyListeners();
    }
  }

  Future<void> getAllOrder(BuildContext context, int type) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "orders?type=$type", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelAllOrder.fromJson(response!.data);
      _order = data;
      notifyListeners();
    }
  }

  Future<void> getDetailPurchase(BuildContext context, String noPo) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "po/$noPo", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDetailPurchase.fromJson(response!.data);
      _detailPurchase = data;
      notifyListeners();
    }
  }

  Future<void> getVendorCategory(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "vendor_categories", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelVendorCategory.fromJson(response!.data);
      _modelVendorCategory = data;
      notifyListeners();
    }
  }

  Future<void> getCity(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "cities", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelCity.fromJson(response!.data);
      _modelCity = data;
      notifyListeners();
    }
  }

  Future<void> createVendor(BuildContext context, String nama, String alamat,
      int vendorCategory, int type, int cityId) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().postRequest(url: "vendors", token: token, data: {
      "name": nama,
      "address": alamat,
      "vendor_category_id": vendorCategory,
      "type": type,
      "city_id": cityId

      // PIC, no telp
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      await getAllVendor(context);
      await getDataVendor(context);

      Navigator.pop(context);
    }
  }

  Future<void> createTerimaBarang(BuildContext context, int poId, int itemId,
      int qty, int warehouseId, String note, String noPo) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: "receiving_orders", token: token, data: {
      "po_id": poId,
      "item_id": itemId,
      "qty": qty,
      "warehouse_id": warehouseId,
      "note": note,
      "status": 1
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      getDetailPO(context, noPo);
    }
  }

  Future<void> updateTerimaBarang(BuildContext context, int poId, int itemId,
      String note, String uuid, String noPo) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().putRequest(
        url: "receiving_order_details/$uuid",
        token: token,
        data: {"po_id": poId, "item_id": itemId, "note": note, "status": 0});

    print(response?.data);
    if (response?.data['error'] == null) {
      getDetailPO(context, noPo);
    }
  }

  String? getCategory(int idCategory) {
    final category = allcategory?.data.firstWhere(
      (category) => category.id == idCategory,
      orElse: () {
        return allItem?.error;
      },
    );
    return category?.name;
  }

  String formatDate(String dateTimeString) {
    // Ubah string ke DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format DateTime menjadi dd-MM-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    // Parse string menjadi DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format waktu sesuai kebutuhan, hanya menampilkan jam, menit, dan detik
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return formattedTime;
  }

  Future<void> getAllSPB(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "spbs", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelSpb.fromJson(response!.data);
      _spb = data;
      notifyListeners();
    }
  }

  Future<void> getLihatSO(BuildContext context, int id) async {
    print("ID MASUK : $id");
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "stock_opnames/details/get-by-id/$id", token: token);

    print(response?.data);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelLihatSo.fromJson(response!.data);
      _lihatSo = data;
      notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailLihatSO(
                    id: id,
                  )));
    }
  }

  Future<void> getDataBpti(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "delivery_note_bpti_available", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelDataBpti.fromJson(response!.data);
      _modelDataBpti = data;
      notifyListeners();
    }
  }

  Future<void> getDetailPenerimaanBarang(
      BuildContext context, String no) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "item_requests/$no", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModeldetailPenerimaanBarang.fromJson(response!.data);
      _modeldetailPenerimaanBarang = data;
      notifyListeners();
    }
  }

  Future<void> getPenerimaanBarang(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "item_requests", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelPenerimaanBarang.fromJson(response!.data);
      _modelPenerimaanBarang = data;
      notifyListeners();
    }
  }

  Future<void> getDetailSPB(BuildContext context, String noSPB) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "spbs/$noSPB", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelDetailSpb.fromJson(response!.data);
      _detailSpb = data;
      notifyListeners();
    }
  }

  Future<void> getAllPo(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().getRequest(url: "po", token: token);

    print(response?.data['data']);
    if (response?.data['error'] == null) {
      final data = ModelPo.fromJson(response!.data);
      _po = data;
      notifyListeners();
    }
  }

  Future<void> getAllCategory(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "categories", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllCategory.fromJson(response!.data);
      _allCategory = data;
      notifyListeners();
    }
  }

  Future<void> getAllLocation(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "locations", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllLocation.fromJson(response!.data);
      _location = data;
      notifyListeners();
    }
  }

  Future<void> getAllUnit(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "units/get-all", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllUnit.fromJson(response!.data);
      _allUnit = data;
      notifyListeners();
    }
  }

  Future<void> getAllVendor(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "vendors", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelSupplier.fromJson(response!.data);
      _supplier = data;
      notifyListeners();
    }
  }

  Future<void> getApprovalVerifikasi(
      BuildContext context, int id, int type) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().getRequest(
        url:
            "stock_opnames/details/get-detail-item-by-detail-id/$id?type=$type",
        token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelApprovalVerifikasi.fromJson(response!.data);
      _approvalVerifikasi = data;
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApprovalVerifikasi(
            id: id,
            type: type,
          ),
        ),
      );
    }
  }

  Future<void> getAllItem(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: 'items', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllItem.fromJson(response!.data);
      _allItem = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createItem(
      BuildContext context,
      String kode,
      String nama,
      int idCategory,
      int idUnit,
      double price,
      int isSell,
      double priceSell,
      int limit,
      int idVendor,
      int isRawMaterial,
      String path) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    print({
      "code": kode,
      "name": nama,
      "category_id": idCategory,
      "unit_id": idUnit,
      "price": price,
      "limit_stock": limit,
      "vendor_id": idVendor,
      "photo": path,
      "is_raw_material": isRawMaterial,
      "is_item_sell": isSell, // 1 = no, 2 = yes
      "sell_price": priceSell, // when is_item_sell
    });
    final response =
        await DioServiceAPI().postRequest(url: 'items', token: token, data: {
      "code": kode,
      "name": nama,
      "category_id": idCategory,
      "unit_id": idUnit,
      "price": price,
      "limit_stock": limit,
      "vendor_id": idVendor,
      "photo": path,
      "is_raw_material": isRawMaterial,
      "is_item_sell": isSell, // 1 = no, 2 = yes
      "sell_price": priceSell, // when is_item_sell
    });

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getAllItem(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Tambah Item',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Tambah Item',
        ),
      );
    }
  }

  Future<void> createSPB(
    BuildContext context,
    String spbDate,
    int spbType,
    List<Map<String, dynamic>> data,
  ) async {
    print({"spb_date": spbDate, "spb_type": spbType, "details": data});
    data = data
        .map((item) => {
              "item_id":
                  int.parse(item["item_id"].toString()), // Pastikan integer
              "qty": int.parse(item["qty"].toString()), // Pastikan integer
              "specification": item["specification"]
                  .toString()
                  .trim() // Pastikan string bersih
            })
        .toList();

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().postRequest(
        url: 'spbs',
        token: token,
        data: {"spb_date": spbDate, "spb_type": spbType, "details": data});

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getAllSPB(context);
      Navigator.pop(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Tambah Item',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Tambah Item',
        ),
      );
    }
  }

  Future<void> createPermintaanBarang(
    BuildContext context,
    int divisiId,
    int pic1,
    int pic2,
    int pic3,
    List<Map<String, dynamic>> data,
  ) async {
    print({
      "divisi": divisiId,
      "pic1": pic1,
      "pic2": pic2,
      "pic3": pic3,
      "details": data
    });
    data = data
        .map((item) => {
              "item_id":
                  int.parse(item["item_id"].toString()), // Pastikan integer
              "qty": int.parse(item["qty"].toString()), // Pastikan integer
              "note": item["note"].toString().trim() // Pastikan string bersih
            })
        .toList();

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: 'item_requests', token: token, data: {
      "division_id": divisiId,
      "pic_verified_by": pic1,
      "pic_acknowledged_by": pic2,
      "pic_approved_by": pic3,
      "details": data
    });

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getPenerimaanBarang(context);
      Navigator.pop(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Permintaan Barang',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Tambah Item',
        ),
      );
    }
  }

  Future<void> updateSerahTerima(
      BuildContext context,
      String uuid,
      String no,
      int isTransfer,
      int qtyR,
      String note,
      String path,
      int warehouseId) async {
    print(uuid);
    print(no);
    print("is_transfer_stock : $isTransfer");
    print("qty_received : $qtyR");
    print("note : $note");
    print("photo : $path");
    print("warehouse_id : $warehouseId");

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().putRequest(
      url: 'item_request_hand_off/$uuid',
      token: token,
      data: {
        "is_transfer_stock": isTransfer,
        "qty_received": qtyR,
        "note": note,
        "photo": path,
        "warehouse_id": warehouseId,
      },
    );

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getDetailPenerimaanBarang(context, no);
      Navigator.pop(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Edit Item',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Edit Item',
        ),
      );
    }
  }

  Future<void> approvalDetailStock(
    BuildContext context,
    int id,
    int type,
    List<Map<String, dynamic>> data,
  ) async {
    data = data
        .map((item) => {
              "id": int.parse(item["id"].toString()), // Pastikan integer
              "real_qty":
                  int.parse(item["real_qty"].toString()), // Pastikan integer
              "result_qty":
                  int.parse(item["result_qty"].toString()), // Pastikan integer
              "status":
                  int.parse(item["status"].toString()), // Pastikan integer
            })
        .toList();
    print("---------------------");
    print(type);
    print("---------------------");
    print(data);

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().putRequest(
        url: 'stock_opnames/details/update-detail-item-by-id/$id',
        token: token,
        data: {"type": type, "details": data});
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getLihatSO(context, id);
      Navigator.pop(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal',
        ),
      );
    }
  }

  Future<void> createPO(
      BuildContext context,
      String poDate,
      String spbNo,
      int spbType,
      int categoryId,
      int vendor,
      int paymentType,
      String paymentDeadline,
      double totalPrice,
      double totalPpn,
      double totalPayment,
      List<Map<String, dynamic>>? payment,
      List<Map<String, dynamic>> details) async {
    details = details
        .map((item) => {
              "item_id":
                  int.parse(item["item_id"].toString()), // Pastikan integer
              "item_price": double.parse(
                  item["item_price"].toString()), // Pastikan integer
              "item_qty":
                  int.parse(item["item_qty"].toString()), // Pastikan integer
              "item_note":
                  item["item_note"].toString().trim() // Pastikan string bersih
            })
        .toList();

    if (payment != null) {
      payment = payment
          .map((item) => {
                "installment_payment_price": double.parse(
                    item["bertahap"].toString()), // Pastikan integer
                "installment_payment_ppn":
                    int.parse(item["%"].toString()), // Pastikan integer
                "installment_payment_total":
                    double.parse(item["total"].toString()),
              })
          .toList();
    }

    print({
      "po_date": poDate,
      "spb_no": spbNo,
      "spb_type": spbType,
      "category_id": categoryId,
      "vendor_id": vendor,
      "payment_type": paymentType,
      "payment_deadline": paymentDeadline,
      "total_price": totalPrice,
      "total_ppn": totalPpn,
      "total_payment": totalPayment,
      "installment_payments": payment,
      "details": details
    });

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    if (paymentType == 1) {
      final response =
          await DioServiceAPI().postRequest(url: 'po', token: token, data: {
        "po_date": poDate,
        "spb_no": spbNo,
        "spb_type": spbType,
        "category_id": categoryId,
        "vendor_id": vendor,
        "payment_type": paymentType,
        "payment_deadline": paymentDeadline,
        "total_price": totalPrice,
        "total_ppn": totalPpn,
        "total_payment": totalPayment,
        "details": details
      });
      print(response?.data['error']);
      if (response?.data['error'] == null) {
        getAllPo(context);
        Navigator.pop(context);
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Berhasil Tambah PO',
          ),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Gagal Tambah PO',
          ),
        );
      }
    } else {
      final response =
          await DioServiceAPI().postRequest(url: 'po', token: token, data: {
        "po_date": poDate,
        "spb_no": spbNo,
        "spb_type": spbType,
        "category_id": categoryId,
        "vendor_id": vendor,
        "payment_type": paymentType,
        "payment_deadline": paymentDeadline,
        "installment_payments": payment,
        "details": details
      });
      print(response?.data['error']);
      if (response?.data['error'] == null) {
        getAllPo(context);
        Navigator.pop(context);
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Berhasil Tambah PO',
          ),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Gagal Tambah PO',
          ),
        );
      }
    }
  }

  Future<void> createPenyesuaian(
      BuildContext context,
      int itemId,
      String operator,
      int quantity,
      String keterangan,
      int pic,
      int warehouseId) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: 'item_adjustments', token: token, data: {
      'item_id': itemId,
      'operator': operator,
      'quantity': quantity,
      'note': keterangan,
      "pic_verified_by": pic,
      "pic_acknowledged_by": pic,
      "pic_approved_by": pic
    });
    final responseMutation = await DioServiceAPI()
        .postRequest(url: 'item_mutations', token: token, data: {
      "item_id": itemId,
      "warehouse_id": warehouseId,
      "operator": operator,
      "quantity": quantity
    });

    print("${response?.data['error']} && ${responseMutation?.data['error']}");
    if (response?.data['error'] == null &&
        responseMutation?.data['error'] == null) {
      Navigator.pop(context);
      await getAllItem(context);
    } else {
      print('error update');
    }
  }

  Future<bool> getDetailSO(
    BuildContext context,
    List<int> categori,
    int warehouseId,
    int soId,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().postRequest(
        url: 'stock_opnames/get-detail-by-category-warehouse-id',
        token: token,
        data: {"categories": categori, "warehouse_id": warehouseId});

    if (response?.data['error'] == null) {
      final data = ModelDetailStock.fromJson(response!.data);
      _detailStock = data;
      notifyListeners();
      return true;
    } else {
      print('error update');
    }
    return false;
  }

  Future<void> createDetailStock(
    BuildContext context,
    int stockId,
    int warehouseId,
    List<int> categori,
    List<Map<String, dynamic>> details,
    int approval1,
    int approval2,
  ) async {
    final stockOpnameData = {
      "stock_opname_id": stockId,
      "warehouse_id": warehouseId,
      "categories": categori,
      "details": details,
      "approval_1": approval1,
      "approval_2": approval2,
    };
    print("----------------------");
    // Mencetak seluruh data
    print(stockOpnameData);
    print("----------------------");

    print(details);
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: 'stock_opnames/details/create', token: token, data: {
      "stock_opname_id": stockId,
      "warehouse_id": warehouseId,
      "categories": categori,
      "details": details,
      "approval_1": approval1,
      "approval_2": approval2,
    });

    if (response?.data['error'] == null) {
      await getAllSO(context);
      await getLihatSO(context, stockId);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print('error update');
    }
  }

  Future<void> getAllWarehouse(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "warehouses", token: token);

    if (response?.data['error'] == null) {
      final data = ModelAllWarehouse.fromJson(response!.data);
      _warehouse = data;
      notifyListeners();
    }
  }

  Future<void> getMutasi(BuildContext context, String uuid) async {
    notifyListeners();

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'item_mutation_by_item_id/$uuid', token: token);
    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelMutasi.fromJson(response!.data);
      _mutasi = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> getAllSO(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (cekLoad == 1) {
      isLoading = false;
      notifyListeners();
    }

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'stock_opnames/get-all', token: token);

    if (response?.data['error'] == null) {
      final data = ModelAllSo.fromJson(response!.data);
      _so = data;
      isLoading = false;
      cekLoad = 1;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createSO(BuildContext context, String keterangan) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().postRequest(
      url: 'stock_opnames/create',
      token: token,
      data: {"note": keterangan},
    );
    if (response?.data != null) {
      getAllSO(context);
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Menambah SO',
        ),
      );
    }
  }

//   Future<void> updateSuratJalan(BuildContext context, String uuid, int type,
//       int? driverId, String? name, String vehicleNumber, int customer) async {
//     if (type == 0) {
//       name = null;
//     }
//     final auth = Provider.of<ProviderAuth>(context, listen: false);
//     final token = auth.auth!.data.accessToken;
//     final response = await DioServiceAPI()
//         .putRequest(url: 'delivery_notes/$uuid', token: token, data: {
//       "type": type,
//       "driver_id": driverId,
//       "name": name,
//       "vehicle_number": vehicleNumber,
//       "customer_id": 1,
//     });

//     print("NAME : $name");

//     print(response?.data);
//     if (response?.data['error'] == null) {
//       await getAllSuratJalan(context);
//       Navigator.pop(context);
//     } else {
//       await getAllSuratJalan(context);
//       Navigator.pop(context);
//     }
//   }
}
