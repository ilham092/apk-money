import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controllers/home_controller.dart';

import '../../city_model.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    required this.provid,
    required this.tipe,
  });
  final provid;
  final tipe;

  @override
  Widget build(BuildContext context) {
    print("${provid} kopi");
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: tipe == "asal"
                ? "Kabupaten / kota Asal"
                : "Kabupaten / kota Tujuan",
          ),
        ),
        popupProps: const PopupPropsMultiSelection.modalBottomSheet(
            showSearchBox: true),
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provid");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "3e392b4981b25a49f9a961022ed393c9",
              },
            );
            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllprovince =
                data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllprovince);
            return models;
          } catch (err) {
            print(err);
            return List<City>.empty();
          }
        },
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (tipe == "asal") {
              controller.kotaAsal.value = int.parse(cityValue.cityId!);
              controller.showButton();
            } else {
              controller.kotaTujuan.value = int.parse(cityValue.cityId!);
              controller.showButton();
            }
          } else {
            if (tipe == "asal") {
            } else {}
          }
        },
        itemAsString: (item) => " ${item.type!} ${item.cityName!}",
      ),
    );
  }
}
