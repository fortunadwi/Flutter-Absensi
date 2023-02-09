// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, implementation_imports, unused_import, unnecessary_import, prefer_is_empty, use_key_in_widget_constructors

import 'package:absensimaps/pages/All%20Absensi/Controller/controller_all_absensi.dart';
import 'package:absensimaps/pages/Homepage/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ViewAllAbsensi extends GetView<ControllerAllAbsensi> {
  @override
  Widget build(BuildContext context) {
    // print(ControllerAllAbsensi);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("All Absensi"),
      ),
      body: GetBuilder<ControllerAllAbsensi>(
        init: ControllerAllAbsensi(),
        builder: (controller) =>
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getAbsensi(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snap.data?.docs.length == 0 || snap.data == null) {
              return const SizedBox(
                height: 150,
                child: Center(
                  child: Text("Belum Ada Riwayat Absensi"),
                ),
              );
            }
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: snap.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snap.data!.docs[index].data();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("/detailAbsensi", arguments: data);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Masuk',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${DateFormat.yMMMEd().format(DateTime.parse(data['date']))}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(data['Masuk']?['date'] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(data['Masuk']!['date']))}"),
                              // Text(
                              //     "${DateFormat.jms().format(DateTime.tryParse(data['Masuk']?['date']) ?? )}"),
                              const SizedBox(height: 10),
                              const Text(
                                "Keluar",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(data['Keluar']?['date'] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(data['Keluar']!['date']))}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Syncfusion Datepicker
          Get.dialog(Dialog(
            //
            child: Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: SfDateRangePicker(
                monthViewSettings:
                    DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                selectionMode: DateRangePickerSelectionMode.range,
                showActionButtons: true,
                onCancel: () {
                  Get.back();
                },
                onSubmit: (obj) {
                  if (obj != null) {
                    if ((obj as PickerDateRange).endDate != null) {
                      // Proses
                      controller.pickDate(obj.startDate!, obj.endDate!);
                    }
                  } else {
                    //
                  }
                },
              ),
            ),
          ));
        },
        child: Icon(Icons.format_list_bulleted_rounded),
      ),
    );
  }
}
