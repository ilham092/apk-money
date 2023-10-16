import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkos_kirim/app/modules/home/courier_model.dart';

class HomeController extends GetxController {
  var hiddenKotAsal = true.obs;
  var providAsal = 0.obs;
  var kotaAsal = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var providTujuan = 0.obs;
  var kotaTujuan = 0.obs;
  var hiddenButtonCek = true.obs;
  var kurir;

  double berat = 0;
  String satuan = "gram";

  void ongkosKirim() async {
    berat = double.tryParse(beratC.text) ?? 0.0;
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(
        url,
        body: {
          "origin": "$kotaAsal",
          "destination": "$kotaTujuan",
          "weight": "$berat",
          "courier": "$kurir",
        },
        headers: {
          'key': '3e392b4981b25a49f9a961022ed393c9',
          'content-type': 'application/x-www-form-urlencoded'
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      // var results = data["rajaongkir"]["results"] as List<dynamic>;

      // var listAllCourier = Courier.fromJsonList;

      print(data);
    } catch (err) {
      print(err);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: err.toString(),
      );
    }
  }

  void showButton() {
    print("${beratC.text} kopi");
    print(kotaAsal);

    if (double.parse(beratC.text) > 0 &&
        kotaAsal.value != 0 &&
        kotaTujuan.value != 0 &&
        kurir != null) {
      hiddenButtonCek.value = false;
    } else {
      hiddenButtonCek.value = true;
    }
  }

  late TextEditingController beratC;

  // void ubahBerat(String value) {
  //   berat = double.tryParse(value) ?? 0.0;
  //   // String cekSatuan = satuan;
  //   // switch (cekSatuan) {
  //   //   case "ton":
  //   //     berat = berat * 1000000;
  //   //     break;
  //   //   case "kwintal":
  //   //     berat = berat * 100000;
  //   //     break;
  //   //   case "ons":
  //   //     berat = berat * 100;
  //   //     break;
  //   //   case "lbs":
  //   //     berat = berat * 22044.62;
  //   //     break;
  //   //   case "pound":
  //   //     berat = berat * 2204.62;
  //   //     break;
  //   //   case "kg":
  //   //     berat = berat * 1000;
  //   //     break;
  //   //   case "hg":
  //   //     berat = berat * 100;
  //   //     break;
  //   //   case "dag":
  //   //     berat = berat * 10;
  //   //     break;
  //   //   case "gram":
  //   //     berat = berat;
  //   //     break;
  //   //   case "cg":
  //   //     berat = berat / 100;
  //   //     break;
  //   //   default:
  //   //     berat = berat;
  //   //     break;
  //   // }
  //   // print(berat);
  //   // print(cekSatuan);
  // }

  void ubahSatuan(String sat) {
    berat = double.tryParse(beratC.text) ?? 0.0;

    print(sat);
    switch (sat) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 22044.62;
        break;
      case "pound":
        berat = berat * 2204.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "cg":
        berat = berat / 100;
        break;
      default:
        berat = berat;
        break;
    }
    print(berat);
    print("Beraaaaaaaat");
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
