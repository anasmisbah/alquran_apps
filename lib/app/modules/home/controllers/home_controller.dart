import 'dart:convert';
import 'dart:developer';

import 'package:alquran_apps/app/constants/color.dart';
import 'package:alquran_apps/app/data/db/bookmark.dart';
import 'package:alquran_apps/app/data/models/juz.dart';
import 'package:alquran_apps/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  List<Surah> allSurah = [];
  List<Juz> allJuz = [];
  RxBool isDark = false.obs;

  RxBool adaDataJuz = false.obs;

  DatabaseManager database = DatabaseManager.instance;

  @override
  void onInit() {
    if (Get.isDarkMode) {
      isDark.value = true;
    }
    super.onInit();
  }

  void deleteLastRead(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");
    update();

    Get.snackbar(
      "Berhasil",
      "Berhasil menghapus penanda",
      colorText: appWhite,
    );
  }

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead =
        await db.query("bookmark", where: 'last_read = 1');
    if (dataLastRead.isEmpty) {
      return null;
    } else {
      return dataLastRead.first;
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");

    var res = await http.get(url);
    List data = (json.decode(res.body) as Map<String, dynamic>)['data'];
    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  Future<List<Juz>> getAllJuz() async {
    adaDataJuz.value = false;
    update();
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
    adaDataJuz.value = true;
    update();
    return allJuz;
  }

  getSurahInJuz(Juz juz) {
    String startInfo = juz.juzStartInfo?.split(' - ').first ?? '';
    String endInfo = juz.juzEndInfo?.split(' - ').first ?? '';
    List<Surah> rawSurahInJuz = [];
    List<Surah> surahInJuz = [];
    for (var item in allSurah) {
      dynamic nameSurahId = item.name?.transliteration?.id;
      rawSurahInJuz.add(item);
      if (nameSurahId == endInfo) {
        break;
      }
    }
    for (var itemRev in rawSurahInJuz.reversed.toList()) {
      dynamic nameSurahId = itemRev.name?.transliteration?.id;
      surahInJuz.add(itemRev);
      if (nameSurahId == startInfo) {
        break;
      }
    }
    return surahInJuz.reversed.toList();
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark = await db.query(
      "bookmark",
      where: 'last_read = 0',
      orderBy: 'surah, via, ayat',
    );
    return allBookmark;
  }

  void deleteBookmark(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");
    update();
    Get.snackbar(
      "Berhasil",
      "Berhasil menghapus bookmark",
      colorText: appWhite,
    );
  }

  void changeThemeMode() {
    final box = GetStorage();
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDark.toggle();

    if (Get.isDarkMode) {
      box.remove('themeDark');
    } else {
      box.write('themeDark', true);
    }
  }
}
