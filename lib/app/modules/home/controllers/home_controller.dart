import 'dart:convert';
import 'dart:developer';

import 'package:alquran_apps/app/data/models/juz.dart';
import 'package:alquran_apps/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool isDark = false.obs;

  @override
  void onInit() {
    if (Get.isDarkMode) {
      isDark.value = true;
    }
    super.onInit();
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");

    var res = await http.get(url);
    List data = (json.decode(res.body) as Map<String, dynamic>)['data'];
    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (var i = 1; i <= 30; i++) {
      Uri url = Uri.parse("https://api.quran.gading.dev/juz/$i");

      var res = await http.get(url);
      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)['data'];
      try {
        Juz juz = Juz.fromJson(data);
        allJuz.add(juz);
      } catch (e) {
        log("$i " + e.toString());
      }
    }
    return allJuz;
  }
}
