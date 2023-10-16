import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ongkos_kirim/app/modules/home/controllers/home_controller.dart';

class Berat extends GetView<HomeController> {
  const Berat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: controller.beratC,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Berat Barang",
                hintText: "Berat Barang",
              ),
              onChanged: (value) {
                controller.showButton();
              },
              //  (value) => controller.ubahBerat(value),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
              ),
              items: const [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Satuan",
                  hintText: "country in menu mode",
                ),
              ),
              onChanged: (value) {
                controller.ubahSatuan(value!);

                controller.showButton();
              },
              selectedItem: "gram",
            ),
          )
        ],
      ),
    );
  }
}
