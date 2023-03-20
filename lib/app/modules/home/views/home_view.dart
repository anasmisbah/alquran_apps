import 'dart:developer';

import 'package:alquran_apps/app/constants/color.dart';
import 'package:alquran_apps/app/data/models/juz.dart' as juzModel;
import 'package:alquran_apps/app/data/models/surah.dart';
import 'package:alquran_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-Quran App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.SEARCH);
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      appPurpleLight2,
                      appPurpleLight1,
                    ],
                  ),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Get.toNamed(Routes.LAST_READ);
                    },
                    child: Container(
                      height: 131,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -28,
                            right: -28,
                            child: Container(
                              width: 206,
                              height: 126,
                              child: Opacity(
                                opacity: 0.7,
                                child: Image.asset(
                                  'assets/images/quran.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_sharp,
                                      color: appWhite,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Terakhir Dibaca",
                                      style: TextStyle(
                                        color: appWhite,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Al-Fatihah",
                                  style: TextStyle(
                                    color: appWhite,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Juz 1 Ayat 5",
                                  style: TextStyle(
                                    color: appWhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Juz",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder(
                    future: controller.getAllSurah(),
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
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          Surah surah = snapshot.data![index];
                          return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_SURAH,
                                  arguments: surah);
                            },
                            leading: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/hexagon.png'))),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: controller.isDark.isTrue
                                          ? appWhite
                                          : appPurple,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              surah.name?.transliteration?.id ?? 'Error...',
                            ),
                            subtitle: Text(
                              "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error...'}",
                              style: TextStyle(
                                color: appTextLight,
                              ),
                            ),
                            trailing: Obx(
                              () => Text(
                                surah.name?.short ?? 'Error...',
                                style: TextStyle(
                                  color: controller.isDark.isTrue
                                      ? appWhite
                                      : appPurple,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  FutureBuilder<List<juzModel.Juz>>(
                    future: controller.getAllJuz(),
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
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          juzModel.Juz juz = snapshot.data![index];

                          String startInfo =
                              juz.juzStartInfo?.split(' - ').first ?? '';
                          String endInfo =
                              juz.juzEndInfo?.split(' - ').first ?? '';
                          List<Surah> rawSurahInJuz = [];
                          List<Surah> surahInJuz = [];
                          for (var item in controller.allSurah) {
                            dynamic nameSurahId =
                                item.name?.transliteration?.id;
                            rawSurahInJuz.add(item);
                            if (nameSurahId == endInfo) {
                              break;
                            }
                          }
                          for (var itemRev in rawSurahInJuz.reversed.toList()) {
                            dynamic nameSurahId =
                                itemRev.name?.transliteration?.id;
                            surahInJuz.add(itemRev);
                            if (nameSurahId == startInfo) {
                              break;
                            }
                          }

                          return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                'juz': juz,
                                'surah': surahInJuz.reversed.toList(),
                              });
                            },
                            leading: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/hexagon.png'),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${juz.juz}",
                                  style: TextStyle(
                                    color:
                                        Get.isDarkMode ? appWhite : appPurple,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              'Juz ${juz.juz}',
                              style: TextStyle(),
                            ),
                            isThreeLine: true,
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Mulai dari ${juz.juzStartInfo}",
                                  style: TextStyle(
                                    color: appTextLight,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Sampai ${juz.juzEndInfo}",
                                  style: TextStyle(
                                    color: appTextLight,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                          ;
                        },
                      );
                    },
                  ),
                  Center(child: Text("Page 3")),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(themeLight)
              : Get.changeTheme(themeDark);
          controller.isDark.toggle();
        },
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appPurpleDark : appWhite,
          ),
        ),
      ),
    );
  }
}
