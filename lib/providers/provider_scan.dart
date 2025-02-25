import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelCard.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderScan with ChangeNotifier {
  ModelCard? _card;
  ModelCard? get card => _card;

  final List<ModelCard> _scanResults = [];

  List<ModelCard> get scanResults => _scanResults;

  int count = 0;
  int maxcount = 5;

  bool isNew = false;

  void newTubeAdd() {
    isNew = true;
    notifyListeners();
  }

  void newTubeClear() {
    isNew = false;
    notifyListeners();
  }

  void resetCount() {
    count = 0;
    notifyListeners();
  }

  void addCount() {
    count++;
    notifyListeners();
  }

  void addScanResult(ModelCard result) {
    _scanResults.add(result);
    notifyListeners();
  }

  void clearResults() {
    _scanResults.clear();
    _qrScannedData.clear();
    notifyListeners();
  }

  Future<bool> verifikasiBPTK(BuildContext context, String noBptk, int isNew,
      String tube, String note) async {
    try {
      final auth = Provider.of<ProviderAuth>(context, listen: false);
      final token = auth.auth!.data.accessToken;

      final response = await DioServiceAPI().postRequest(
        url: 'bptks_detail/$noBptk',
        token: token,
        data: {"is_new": isNew, "tube_no": tube, "note": note},
      );

      if (response?.data['error'] != null) return false;

      return true;
    } catch (e) {
      print("Error in verifikasiBPTK: $e");
      return false;
    }
  }

  // scan BPTI
  Future<bool> scanBPTI(
      BuildContext context, String noBPTK, String tube) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: "bptis_detail/$noBPTK", token: token, data: {
      "is_new": 0,
      "tube_no": tube,
      "type": 0,
      "cradle_id": null,
    });

    print(response?.data);

    if (response!.data['error'] != null) {
      return false;
    }

    return true;
  }

  Future<bool>? getDataCard(BuildContext context, String code) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .getRequest(url: 'tubes_codes/$code', token: token);
    print(response?.data);
    if (response!.data['error'] != null) {
      return false;
    }
    final data = ModelCard.fromJson(response.data);
    _card = data;
    addScanResult(data);
    notifyListeners();
    print(scanResults.length);
    return true;
  }

  int scanSuccessCount = 0; // Counter untuk scan yang berhasil
  int scanFailureCount = 0; // Counter untuk scan yang gagal
  bool _isDuplicateMessageShown =
      false; // Flag untuk memastikan pesan hanya muncul sekali

  // List untuk menyimpan data yang di-scan berdasarkan kategori
  final List<String> _bptiScannedData = [];
  final List<String> _qrScannedData = [];
  final List<String> _blastScannedData = [];
  final List<String> _verfikasiScannedData = [];
  final List<String> _mencurigakanScannedData = [];

  String?
      _lastScannedCode; // Variable untuk menyimpan kode terakhir yang di-scan

  // Getter untuk tiap kategori hasil scan
  List<String> get bptiScannedData => _bptiScannedData;
  List<String> get qrScannedData => _qrScannedData;
  List<String> get blastScannedData => _blastScannedData;

  List<String> get verfikasiScannedData => _verfikasiScannedData;
  List<String> get mencurigakanScannedData => _mencurigakanScannedData;

  // untuk button camera
  bool _isFlashOn = false;
  bool get isFlashOn => _isFlashOn;

  void toggleFlash() {
    _isFlashOn = !_isFlashOn;
    notifyListeners();
  }

  // Menambahkan hasil scan berdasarkan kategori
  void addScannedData(String data, String category) {
    switch (category) {
      case 'BPTI':
        if (!_bptiScannedData.contains(data)) {
          _bptiScannedData.add(data);
          scanSuccessCount++;
          _lastScannedCode = data;
          _isDuplicateMessageShown = false;
          notifyListeners();
        }
        break;
      case 'QR':
        if (!_qrScannedData.contains(data)) {
          _qrScannedData.add(data);
          scanSuccessCount++;
          _lastScannedCode = data;
          _isDuplicateMessageShown = false;
          notifyListeners();
        }
        break;
      case 'BLAST':
        if (!_blastScannedData.contains(data)) {
          _blastScannedData.add(data);
          scanSuccessCount++;
          _lastScannedCode = data;
          _isDuplicateMessageShown = false;
          notifyListeners();
        }
        break;
      case 'VERIFIKASI':
        if (!_verfikasiScannedData.contains(data)) {
          _verfikasiScannedData.add(data);
          scanSuccessCount++;
          _lastScannedCode = data;
          _isDuplicateMessageShown = false;
          notifyListeners();
        }
        break;
      case 'MENCURIGAKAN':
        if (!_mencurigakanScannedData.contains(data)) {
          _mencurigakanScannedData.add(data);
          scanSuccessCount++;
          _lastScannedCode = data;
          _isDuplicateMessageShown = false;
          notifyListeners();
        }
        break;
      default:
        // Bisa tambahkan kategori lain jika dibutuhkan
        break;
    }
  }

  // Memeriksa apakah kode sudah pernah discan berdasarkan kategori
  bool isCodeScanned(String code, String category) {
    switch (category) {
      case 'BPTI':
        return _bptiScannedData.contains(code);
      case 'QR':
        return _qrScannedData.contains(code);
      case 'BLAST':
        return _blastScannedData.contains(code);
      case 'VERIFIKASI':
        return _verfikasiScannedData.contains(code);
      case 'MENCURIGAKAN':
        return _mencurigakanScannedData.contains(code);
      default:
        return false;
    }
  }

  // Menghapus semua hasil scan berdasarkan kategori
  void clearScannedData(String category) {
    switch (category) {
      case 'BPTI':
        _bptiScannedData.clear();
        break;
      case 'QR':
        _qrScannedData.clear();
        break;
      case 'BLAST':
        _blastScannedData.clear();
        break;
      case 'VERIFIKASI':
        _verfikasiScannedData.clear();
        break;
      case 'MENCURIGAKAN':
        _mencurigakanScannedData.clear();
        break;
      default:
        break;
    }
    notifyListeners();
  }

  // Menghapus semua hasil scan di semua kategori
  void clearAllScannedData() {
    _bptiScannedData.clear();
    _qrScannedData.clear();
    _blastScannedData.clear();
    _verfikasiScannedData.clear();
    _mencurigakanScannedData.clear();
    notifyListeners();
  }

  void clearScannedCount() {
    scanSuccessCount = 0;
    scanFailureCount = 0;
    notifyListeners();
  }

  void scanFailureCountF() {
    scanFailureCount++;
    notifyListeners();
  }

  // Mengecek apakah pesan duplikat harus ditampilkan
  bool shouldShowDuplicateMessage(String code) {
    if (_lastScannedCode == code && _isDuplicateMessageShown) {
      return false;
    } else {
      _isDuplicateMessageShown = true;
      return true;
    }
  }

  // Reset status duplikat setiap kali kode yang baru di-scan
  void resetLastScannedCode() {
    _lastScannedCode = null;
    _isDuplicateMessageShown = false;
  }
}

// import 'package:flutter/material.dart';

// class ProviderScan with ChangeNotifier {
//   int scanSuccessCount = 0; // Counter untuk scan yang berhasil
//   int scanFailureCount = 0; // Counter untuk scan yang gagal
//   List<String> _scannedData = [];
//   String?
//       _lastScannedCode; // Variable untuk menyimpan kode terakhir yang di-scan
//   bool _isDuplicateMessageShown =
//       false; // Flag untuk memastikan pesan hanya muncul sekali

//   List<String> get scannedData => _scannedData;

//   // untuk button camera
//   bool _isFlashOn = false;

//   bool get isFlashOn => _isFlashOn;

//   void toggleFlash() {
//     _isFlashOn = !_isFlashOn;
//     notifyListeners();
//   }

//   // Menambahkan hasil scan jika belum ada dalam list
//   void addScannedData(String data) {
//     if (!_scannedData.contains(data)) {
//       _scannedData.add(data);
//       scanSuccessCount++;
//       _lastScannedCode = data; // Simpan kode yang baru di-scan
//       _isDuplicateMessageShown =
//           false; // Reset flag untuk kode baru yang di-scan
//       notifyListeners();
//     }
//   }

//   // Memeriksa apakah kode sudah pernah discan
//   bool isCodeScanned(String code) {
//     return _scannedData.contains(code);
//   }

//   // Menghapus semua hasil scan
//   void clearScannedData() {
//     _scannedData.clear();
//     notifyListeners();
//   }

//   void clearScannedCount() {
//     scanSuccessCount = 0; // Counter untuk scan yang berhasil
//     scanFailureCount = 0; // Counter untuk scan yang gagal
//     notifyListeners();
//   }

//   void ScanFailureCount() {
//     scanFailureCount++;
//     notifyListeners();
//   }

//   // Mengecek apakah pesan duplikat harus ditampilkan
//   bool shouldShowDuplicateMessage(String code) {
//     if (_lastScannedCode == code && _isDuplicateMessageShown) {
//       return false; // Jangan tampilkan pesan lagi jika sudah muncul untuk kode ini
//     } else {
//       _isDuplicateMessageShown = true; // Tampilkan pesan sekali dan set flag
//       return true;
//     }
//   }

//   // Reset status duplikat setiap kali kode yang baru di-scan
//   void resetLastScannedCode() {
//     _lastScannedCode = null;
//     _isDuplicateMessageShown = false;
//   }
// }
