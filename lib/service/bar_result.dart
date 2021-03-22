import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCodeResultService extends ChangeNotifier {
  String _result = 'unknown';
  String get result => _result;

  var _fetchBook = [];
  get book => _fetchBook;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      fetchBook(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    _result = barcodeScanRes;
    notifyListeners();
  }

  Future fetchBook(String res) async {
    print(res);
    try {
      final Response response = await Dio().get(
        'https://odd-walrus-49.loca.lt/fetch?accNo=$res',
      );
      if (response.statusCode == 200) {
        _fetchBook = response.data;
        print(response.data);
        notifyListeners();
      } else {
        _result = "Could not find ";
        notifyListeners();
        print(response.statusCode);
      }
    } on SocketException {
      print("no conection");
    } catch (e) {
      _result = "Could not find ";
      notifyListeners();
    }
  }
}
