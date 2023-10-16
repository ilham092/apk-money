import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../province_model.dart';
import 'package:http/http.dart' as http;

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    required this.tipe,
    super.key,
  });
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
          ),
        ),
        popupProps: const PopupPropsMultiSelection.modalBottomSheet(
            showSearchBox: true),
        asyncItems: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

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

            var models = Province.fromJsonList(listAllprovince);
            return models;
          } catch (err) {
            print(err);
            return List<Province>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == "asal") {
              controller.providAsal.value = int.parse(prov.provinceId!);
              controller.hiddenKotAsal.value = false;
            } else {
              controller.providTujuan.value = int.parse(prov.provinceId!);
              controller.hiddenKotaTujuan.value = false;
            }
          } else {
            if (tipe == "asal") {
              controller.hiddenKotAsal.value = true;
            } else {
              controller.hiddenKotaTujuan.value = true;
            }
          }
        },
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
