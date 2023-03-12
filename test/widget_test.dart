import 'dart:convert';

import 'package:alquran_apps/app/data/models/detail_surah.dart';
import 'package:alquran_apps/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah");

  var res = await http.get(url);

  var data = (json.decode(res.body) as Map<String, dynamic>)['data'];
  // print(data);

  // data dari api (raw data) -> ke model dart
  Surah dataSurah = Surah.fromJson(data[113]);
  // print(dataSurah.toJson());

  Uri urlAnnas =
      Uri.parse("https://api.quran.gading.dev/surah/${dataSurah.number}");

  var resAnnas = await http.get(urlAnnas);
  var dataAnnas = (json.decode(resAnnas.body) as Map<String, dynamic>)['data'];
  DetailSurah detailSurahAnnas = DetailSurah.fromJson(dataAnnas);
  print(detailSurahAnnas.verses?[0].text?.arab);
}
