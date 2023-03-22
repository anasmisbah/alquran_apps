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
              GetBuilder<HomeController>(
                builder: (ctrl) {
                  return FutureBuilder(
                    future: ctrl.getLastRead(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                appPurpleLight2,
                                appPurpleLight1,
                              ],
                            ),
                          ),
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
                                      "Loading....",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                appPurpleLight2,
                                appPurpleLight1,
                              ],
                            ),
                          ),
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
                                      height: 45,
                                    ),
                                    Text(
                                      "Belum ada bacaan terakhir",
                                      style: TextStyle(
                                        color: appWhite,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      Map<String, dynamic>? lastRead = snapshot.data;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
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
                            onLongPress: () {
                              if (lastRead != null) {
                                Get.defaultDialog(
                                    title: "Hapus bacaan terakhir",
                                    middleText:
                                        "Anda ingin menghapus penanda bacaan terakhir?",
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "Batal",
                                          style: TextStyle(
                                            color: appPurple,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: appPurpleLight2),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          ctrl.deleteLastRead(lastRead['id']);
                                          Get.back();
                                        },
                                        child: Text("Iya, hapus"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: appPurple,
                                        ),
                                      ),
                                    ]);
                              }
                            },
                            onTap: () {
                              if (lastRead != null) {
                                switch (lastRead['via']) {
                                  case 'juz':
                                    // print(data);
                                    // print(data['juz'] - 1);
                                    var detailJuz =
                                        controller.allJuz[lastRead['juz'] - 1];
                                    // print(controller.allJuz[26].toJson());
                                    Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                      'juz': detailJuz,
                                      'surah':
                                          controller.getSurahInJuz(detailJuz),
                                      'bookmark': lastRead,
                                    });
                                    break;
                                  case 'surah':
                                    Get.toNamed(Routes.DETAIL_SURAH,
                                        arguments: {
                                          'name': lastRead['surah']
                                              .toString()
                                              .replaceAll("+", "'"),
                                          'id': lastRead['number_surah'],
                                          'bookmark': lastRead,
                                        });
                                    break;
                                  default:
                                }
                              }
                            },
                            child: Container(
                              height: 131,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          "${lastRead?['surah'].toString().replaceAll("+", "'")}",
                                          style: TextStyle(
                                            color: appWhite,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "Juz ${lastRead?['juz']} Ayat ${lastRead?['ayat']}",
                                          style: TextStyle(
                                            color: appWhite,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
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
                              Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                'id': surah.number,
                                'name': surah.name?.transliteration?.id
                              });
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

                          return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                'juz': juz,
                                'surah': controller.getSurahInJuz(juz),
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
                                child: Obx(() => Text(
                                      "${juz.juz}",
                                      style: TextStyle(
                                        color: controller.isDark.isTrue
                                            ? appWhite
                                            : appPurple,
                                      ),
                                    )),
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
                  GetBuilder<HomeController>(
                    builder: (c) {
                      if (c.adaDataJuz.isFalse) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Sedang menunggu data juz"),
                            ],
                          ),
                        );
                      } else {
                        return FutureBuilder(
                          future: c.getBookmark(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text('Tidak ada Bookmark'),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text('Tidak ada Bookmark'),
                              );
                            }
                            return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    switch (data['via']) {
                                      case 'juz':
                                        // print(data);
                                        // print(data['juz'] - 1);
                                        var detailJuz =
                                            controller.allJuz[data['juz'] - 1];
                                        // print(controller.allJuz[26].toJson());
                                        Get.toNamed(Routes.DETAIL_JUZ,
                                            arguments: {
                                              'juz': detailJuz,
                                              'surah': controller
                                                  .getSurahInJuz(detailJuz),
                                              'bookmark': data,
                                            });
                                        break;
                                      case 'surah':
                                        Get.toNamed(Routes.DETAIL_SURAH,
                                            arguments: {
                                              'name': data['surah']
                                                  .toString()
                                                  .replaceAll("+", "'"),
                                              'id': data['number_surah'],
                                              'bookmark': data,
                                            });
                                        break;
                                      default:
                                    }
                                  },
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hexagon.png'),
                                      ),
                                    ),
                                    child: Center(
                                      child: Obx(() => Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                              color: controller.isDark.isTrue
                                                  ? appWhite
                                                  : appPurple,
                                            ),
                                          )),
                                    ),
                                  ),
                                  title: Text(
                                    '${data['surah'].toString().replaceAll("+", "'")}',
                                    style: TextStyle(),
                                  ),
                                  subtitle: Text(
                                    "Ayat ${data['ayat']} via ${data['via']}",
                                    style: TextStyle(
                                      color: appTextLight,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      c.deleteBookmark(data['id']);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeThemeMode();
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
