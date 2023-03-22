import 'package:alquran_apps/app/constants/color.dart';
import 'package:alquran_apps/app/data/models/juz.dart' as juz;
import 'package:alquran_apps/app/data/models/detail_surah.dart' as detail;
import 'package:alquran_apps/app/data/models/surah.dart';
import 'package:alquran_apps/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  DetailJuzView({Key? key}) : super(key: key);
  final juz.Juz detailJuz = Get.arguments['juz'];
  final List<Surah> allSurahInThisJuz = Get.arguments['surah'];
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JUZ ${detailJuz.juz}"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            itemCount: detailJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                return Center(
                  child: Text("Tidak ada data"),
                );
              }
              juz.Verse? ayat = detailJuz.verses?[index];
              if (index != 0) {
                if (ayat?.number?.inSurah == 1) {
                  controller.index++;
                }
              }
              Surah surah = allSurahInThisJuz[controller.index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ayat?.number?.inSurah == 1
                      ? GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Tafsir",
                              titleStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              content: Container(
                                child: Text(
                                  "(${surah.tafsir?.id ?? 'Tidak ada tafsir'})",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: linear,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -20,
                                  right: 0,
                                  child: Opacity(
                                    opacity: 0.2,
                                    child: Image.asset(
                                      "assets/images/quran.png",
                                      scale: 0.8,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${surah.name?.transliteration?.id}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: appWhite,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "(${surah.name?.translation?.id?.toUpperCase() ?? 'error...'})",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: appWhite,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Divider(
                                            color: appWhite,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${surah.numberOfVerses ?? 'error...'} Ayat | ${surah.revelation?.id}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: appWhite,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 32,
                                        ),
                                        Image.asset(
                                            'assets/images/bismillah.png'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                      color: appPurpleLight2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 15,
                                ),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/hexagon.png",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${ayat?.number?.inSurah}",
                                    style: TextStyle(
                                      color:
                                          Get.isDarkMode ? appWhite : appPurple,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${surah.name?.transliteration?.id}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          GetBuilder<DetailJuzController>(
                            builder: (ctrl) {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: "BOOKMARK",
                                          middleText: "Pilih Jenis Bookmark",
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await ctrl.addBookmark(
                                                    true, surah, ayat, index);
                                                homeC.update();
                                              },
                                              child: Text("LAST READ"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: appPurple,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                ctrl.addBookmark(
                                                    false, surah, ayat, index);
                                              },
                                              child: Text("BOOKMARK"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: appPurple,
                                              ),
                                            ),
                                          ]);
                                    },
                                    icon: Icon(
                                      Icons.bookmark_add_outlined,
                                      color:
                                          Get.isDarkMode ? appWhite : appPurple,
                                    ),
                                  ),
                                  (ayat?.kondisiAudio == "stop")
                                      ? IconButton(
                                          onPressed: () {
                                            ctrl.playAudio(ayat);
                                          },
                                          icon: Icon(
                                            Icons.play_arrow_outlined,
                                            color: Get.isDarkMode
                                                ? appWhite
                                                : appPurple,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (ayat?.kondisiAudio == "playing")
                                                ? IconButton(
                                                    onPressed: () {
                                                      ctrl.pauseAudio(ayat);
                                                    },
                                                    icon: Icon(
                                                      Icons.pause,
                                                      color: Get.isDarkMode
                                                          ? appWhite
                                                          : appPurple,
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      ctrl.resumeAudio(ayat);
                                                    },
                                                    icon: Icon(
                                                      Icons.play_arrow_outlined,
                                                      color: Get.isDarkMode
                                                          ? appWhite
                                                          : appPurple,
                                                    ),
                                                  ),
                                            IconButton(
                                              onPressed: () {
                                                ctrl.stopAudio(ayat);
                                              },
                                              icon: Icon(
                                                Icons.stop,
                                                color: Get.isDarkMode
                                                    ? appWhite
                                                    : appPurple,
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "${ayat?.text?.arab}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat?.text?.transliteration?.en}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat?.translation?.id}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
