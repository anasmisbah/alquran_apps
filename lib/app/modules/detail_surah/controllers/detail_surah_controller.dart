import 'dart:convert';
import 'dart:ffi';

import 'package:alquran_apps/app/constants/color.dart';
import 'package:alquran_apps/app/data/db/bookmark.dart';
import 'package:alquran_apps/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {
  // RxString kondisiAudio = "stop".obs;
  final player = AudioPlayer();

  Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");

    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];
    return DetailSurah.fromJson(data);
  }

  void addBookmark(
    bool lastRead,
    DetailSurah? detailSurah,
    Verse? ayat,
    int indexAyat,
  ) async {
    Database db = await database.db;
    bool flagExist = false;
    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List check = await db.query("bookmark",
          where:
              "surah = '${detailSurah?.name?.transliteration?.id}' and ayat = ${ayat?.number?.inSurah} and juz = ${ayat?.meta?.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");
      if (check.isNotEmpty) {
        flagExist = true;
      }
    }
    if (flagExist == false) {
      db.insert("bookmark", {
        'surah': "${detailSurah?.name?.transliteration?.id}",
        'ayat': ayat?.number?.inSurah,
        'juz': ayat?.meta?.juz,
        'via': 'surah',
        'index_ayat': indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });
      Get.back();
      Get.snackbar("berhasil", "Berhasil menambahkan bookmark",
          colorText: appWhite);
    } else {
      Get.back();
      Get.snackbar("Terjadi kesalahan", "Gagal menambahkan bookmark",
          colorText: appWhite);
    }

    var data = await db.query("bookmark");
    print(data);
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      // proses
      // Catching errors at load time
      try {
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat?.audio?.primary ?? '');
        ayat?.kondisiAudio = "playing";
        update();
        await player.play();
        ayat?.kondisiAudio = "stop";
        update();
        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "${e.message}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'An error occured: $e',
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "URL audio tidak dapat diakses",
      );
    }
  }

  void pauseAudio(Verse? ayat) async {
    try {
      await player.pause();
      ayat?.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'An error occured: $e',
      );
    }
  }

  void resumeAudio(Verse? ayat) async {
    try {
      ayat?.kondisiAudio = "playing";
      update();
      await player.play();
      ayat?.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'An error occured: $e',
      );
    }
  }

  void stopAudio(Verse? ayat) async {
    try {
      await player.stop();
      ayat?.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'An error occured: $e',
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    player.dispose();
    super.onClose();
  }
}
