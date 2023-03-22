import 'dart:developer';

import 'package:alquran_apps/app/constants/color.dart';
import 'package:alquran_apps/app/data/models/detail_surah.dart' as detail;
import 'package:alquran_apps/app/data/models/surah.dart';
import 'package:alquran_apps/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  // final Surah surah = Get.arguments;
  final homeC = Get.find<HomeController>();
  late Map<String, dynamic> bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "SURAH ${Get.arguments['name']?.toString().toUpperCase() ?? 'error...'}"),
        centerTitle: true,
      ),
      body: FutureBuilder<detail.DetailSurah>(
        future: controller.getDetailSurah(Get.arguments['id'].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('Tidak ada Data'),
            );
          }
          if (Get.arguments["bookmark"] != null) {
            bookmark = Get.arguments['bookmark'];
            if (int.parse(bookmark['index_ayat']) > 0) {
              controller.scrollController.scrollToIndex(
                int.parse(bookmark['index_ayat']) + 2,
                preferPosition: AutoScrollPosition.begin,
              );
            }
          }
          detail.DetailSurah detailSurah = snapshot.data!;

          List<Widget> allAyat = List.generate(
            snapshot.data?.verses?.length ?? 0,
            (index) {
              detail.Verse? ayat = snapshot.data?.verses?[index];
              return AutoScrollTag(
                controller: controller.scrollController,
                key: ValueKey(index + 2),
                index: index + 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
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
                            Container(
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
                            GetBuilder<DetailSurahController>(
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
                                                      true,
                                                      snapshot.data,
                                                      ayat,
                                                      index);
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
                                                      false,
                                                      snapshot.data,
                                                      ayat,
                                                      index);
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
                                        color: Get.isDarkMode
                                            ? appWhite
                                            : appPurple,
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
                                                        Icons
                                                            .play_arrow_outlined,
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
                            )
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
                      height: 20,
                    )
                  ],
                ),
              );
            },
          );
          return ListView(
            controller: controller.scrollController,
            padding: EdgeInsets.all(20),
            children: [
              AutoScrollTag(
                controller: controller.scrollController,
                key: ValueKey(0),
                index: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Tafsir",
                      titleStyle: TextStyle(fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      content: Container(
                        child: Text(
                          "(${detailSurah.tafsir?.id ?? 'Tidak ada tafsir'})",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  },
                  child: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${detailSurah.name?.transliteration?.id?.toUpperCase() ?? 'error...'}",
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
                                  "(${detailSurah.name?.translation?.id?.toUpperCase() ?? 'error...'})",
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
                                  "${detailSurah.numberOfVerses ?? 'error...'} Ayat | ${detailSurah.revelation?.id}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: appWhite,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Image.asset('assets/images/bismillah.png'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AutoScrollTag(
                controller: controller.scrollController,
                key: ValueKey(1),
                index: 1,
                child: SizedBox(
                  height: 20,
                ),
              ),
              ...allAyat
            ],
          );
        },
      ),
    );
  }
}
