// To parse this JSON data, do
//
//     final detailSurah = detailSurahFromJson(jsonString);

import 'dart:convert';

DetailSurah detailSurahFromJson(String str) => DetailSurah.fromJson(json.decode(str));

String detailSurahToJson(DetailSurah data) => json.encode(data.toJson());

class DetailSurah {
    DetailSurah({
        this.number,
        this.meta,
        this.text,
        this.translation,
        this.audio,
        this.tafsir,
        this.surah,
    });

    Number? number;
    Meta? meta;
    Text? text;
    Translation? translation;
    Audio? audio;
    DetailSurahTafsir? tafsir;
    Surah? surah;

    factory DetailSurah.fromJson(Map<String, dynamic> json) => DetailSurah(
        number: json["number"] == null ? null : Number.fromJson(json["number"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        text: json["text"] == null ? null : Text.fromJson(json["text"]),
        translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
        tafsir: json["tafsir"] == null ? null : DetailSurahTafsir.fromJson(json["tafsir"]),
        surah: json["surah"] == null ? null : Surah.fromJson(json["surah"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number?.toJson(),
        "meta": meta?.toJson(),
        "text": text?.toJson(),
        "translation": translation?.toJson(),
        "audio": audio?.toJson(),
        "tafsir": tafsir?.toJson(),
        "surah": surah?.toJson(),
    };
}

class Audio {
    Audio({
        this.primary,
        this.secondary,
    });

    String? primary;
    List<String>? secondary;

    factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: json["secondary"] == null ? [] : List<String>.from(json["secondary"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary == null ? [] : List<dynamic>.from(secondary!.map((x) => x)),
    };
}

class Meta {
    Meta({
        this.juz,
        this.page,
        this.manzil,
        this.ruku,
        this.hizbQuarter,
        this.sajda,
    });

    int? juz;
    int? page;
    int? manzil;
    int? ruku;
    int? hizbQuarter;
    Sajda? sajda;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"] == null ? null : Sajda.fromJson(json["sajda"]),
    );

    Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda?.toJson(),
    };
}

class Sajda {
    Sajda({
        this.recommended,
        this.obligatory,
    });

    bool? recommended;
    bool? obligatory;

    factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
        recommended: json["recommended"],
        obligatory: json["obligatory"],
    );

    Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
    };
}

class Number {
    Number({
        this.inQuran,
        this.inSurah,
    });

    int? inQuran;
    int? inSurah;

    factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
    );

    Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
    };
}

class Surah {
    Surah({
        this.number,
        this.sequence,
        this.numberOfVerses,
        this.name,
        this.revelation,
        this.tafsir,
        this.preBismillah,
    });

    int? number;
    int? sequence;
    int? numberOfVerses;
    Name? name;
    Revelation? revelation;
    SurahTafsir? tafsir;
    dynamic preBismillah;

    factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        sequence: json["sequence"],
        numberOfVerses: json["numberOfVerses"],
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        revelation: json["revelation"] == null ? null : Revelation.fromJson(json["revelation"]),
        tafsir: json["tafsir"] == null ? null : SurahTafsir.fromJson(json["tafsir"]),
        preBismillah: json["preBismillah"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name?.toJson(),
        "revelation": revelation?.toJson(),
        "tafsir": tafsir?.toJson(),
        "preBismillah": preBismillah,
    };
}

class Name {
    Name({
        this.short,
        this.long,
        this.transliteration,
        this.translation,
    });

    String? short;
    String? long;
    Translation? transliteration;
    Translation? translation;

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        short: json["short"],
        long: json["long"],
        transliteration: json["transliteration"] == null ? null : Translation.fromJson(json["transliteration"]),
        translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
    );

    Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration?.toJson(),
        "translation": translation?.toJson(),
    };
}

class Translation {
    Translation({
        this.en,
        this.id,
    });

    String? en;
    String? id;

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json["en"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
    };
}

class Revelation {
    Revelation({
        this.arab,
        this.en,
        this.id,
    });

    String? arab;
    String? en;
    String? id;

    factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: json["arab"],
        en: json["en"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
    };
}

class SurahTafsir {
    SurahTafsir({
        this.id,
    });

    String? id;

    factory SurahTafsir.fromJson(Map<String, dynamic> json) => SurahTafsir(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class DetailSurahTafsir {
    DetailSurahTafsir({
        this.id,
    });

    Id? id;

    factory DetailSurahTafsir.fromJson(Map<String, dynamic> json) => DetailSurahTafsir(
        id: json["id"] == null ? null : Id.fromJson(json["id"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
    };
}

class Id {
    Id({
        this.short,
        this.long,
    });

    String? short;
    String? long;

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        short: json["short"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
    };
}

class Text {
    Text({
        this.arab,
        this.transliteration,
    });

    String? arab;
    Transliteration? transliteration;

    factory Text.fromJson(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: json["transliteration"] == null ? null : Transliteration.fromJson(json["transliteration"]),
    );

    Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration?.toJson(),
    };
}

class Transliteration {
    Transliteration({
        this.en,
    });

    String? en;

    factory Transliteration.fromJson(Map<String, dynamic> json) => Transliteration(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}
