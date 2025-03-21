import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/modelAllSuratJalan.dart';
import 'provider_auth.dart';

class ProviderSuratJalan extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = false;
  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  ModelAllSuratJalan? _suratJalan;

  ModelAllSuratJalan? get suratJalan => _suratJalan;

  Future<void> getAllSuratJalan(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: 'delivery_notes', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllSuratJalan.fromJson(response!.data);
      _suratJalan = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createSuratJalan(
    BuildContext context,
    int orderId,
    List<Map<String, dynamic>> data,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    data = data
        .map((item) => {
              "id": int.parse(item["id"].toString()), // Pastikan integer
            })
        .toList();

    final response = await DioServiceAPI().postRequest(
        url: "delivery_notes",
        token: token,
        data: {"order_id": orderId, "details": data});

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      Navigator.pop(context);
      Navigator.pop(context);
      getAllSuratJalan(context);
    }
  }

  Future<void> updateSuratJalan(BuildContext context, String uuid, int type,
      int? driverId, String? name, String vehicleNumber, int customer) async {
    if (type == 0) {
      name = null;
    }
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .putRequest(url: 'delivery_notes/$uuid', token: token, data: {
      "type": type,
      "driver_id": driverId,
      "name": name,
      "vehicle_number": vehicleNumber,
      "customer_id": 1,
    });

    print("NAME : $name");

    print(response?.data);
    if (response?.data['error'] == null) {
      await getAllSuratJalan(context);
      Navigator.pop(context);
    } else {
      await getAllSuratJalan(context);
      Navigator.pop(context);
    }
  }
}
