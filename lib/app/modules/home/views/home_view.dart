import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkos_kirim/app/modules/home/province_model.dart';
import 'package:ongkos_kirim/app/modules/home/views/widgets/berat.dart';
import 'package:ongkos_kirim/app/modules/home/views/widgets/kota.dart';
import '../controllers/home_controller.dart';

import 'widgets/povinsi.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Provinsi(tipe: "asal"),
            Obx(
              () => controller.hiddenKotAsal.isTrue
                  ? const SizedBox()
                  : Kota(
                      provid: controller.providAsal.value,
                      tipe: "asal",
                    ),
            ),
            const Provinsi(tipe: "Tujuan"),
            Obx(
              () => controller.hiddenKotaTujuan.isTrue
                  ? const SizedBox()
                  : Kota(
                      tipe: "Tujuan",
                      provid: controller.providTujuan.value,
                    ),
            ),
            const Berat(),
            DropdownSearch<Map<String, dynamic>>(
              items: const [
                {
                  "code": "jne",
                  "name": "jalur nugraha kurir",
                },
                {
                  "code": "tiki",
                  "name": "titipan kilat",
                },
                {
                  "code": "pos",
                  "name": "perusahaan opsionla surat",
                }
              ],
              itemAsString: (item) => "${item["name"]}",
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${item["name"]}",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pilih Kurir",
                  hintText: "country in menu mode",
                ),
              ),
              onChanged: (value) {
                controller.kurir = value;
                controller.showButton();
              },
            ),

            //////////////////////////
            const SizedBox(
              height: 50,
            ),
            Obx(
              () => controller.hiddenButtonCek.isTrue
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        controller.ongkosKirim();
                      },
                      child: const Text("Cek Ongkos Kirim"),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          primary: Colors.red),
                    ),
            ) 
          ],
        ),
      ),
    );
  }
}
