import 'dart:convert';

class GetWeatherResponseModel {
  Lokasi? lokasi;
  List<Datum>? data;

  GetWeatherResponseModel({
    this.lokasi,
    this.data,
  });

  factory GetWeatherResponseModel.fromJson(String str) =>
      GetWeatherResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetWeatherResponseModel.fromMap(Map<String, dynamic> json) =>
      GetWeatherResponseModel(
        lokasi: json["lokasi"] == null ? null : Lokasi.fromMap(json["lokasi"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "lokasi": lokasi?.toMap(),
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Lokasi? lokasi;
  List<List<Cuaca>>? cuaca;

  Datum({
    this.lokasi,
    this.cuaca,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        lokasi: json["lokasi"] == null ? null : Lokasi.fromMap(json["lokasi"]),
        cuaca: json["cuaca"] == null
            ? []
            : List<List<Cuaca>>.from(json["cuaca"]!
                .map((x) => List<Cuaca>.from(x.map((x) => Cuaca.fromMap(x))))),
      );

  Map<String, dynamic> toMap() => {
        "lokasi": lokasi?.toMap(),
        "cuaca": cuaca == null
            ? []
            : List<dynamic>.from(
                cuaca!.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
      };
}

class Cuaca {
  DateTime? datetime;
  int? t;
  int? tcc;
  int? weather;
  String? weatherDesc;
  String? weatherDescEn;
  int? wdDeg;
  String? wd;
  String? wdTo;
  double? ws;
  int? hu;
  int? vs;
  String? vsText;
  String? timeIndex;
  DateTime? analysisDate;
  String? image;
  DateTime? utcDatetime;
  DateTime? localDatetime;

  Cuaca({
    this.datetime,
    this.t,
    this.tcc,
    this.weather,
    this.weatherDesc,
    this.weatherDescEn,
    this.wdDeg,
    this.wd,
    this.wdTo,
    this.ws,
    this.hu,
    this.vs,
    this.vsText,
    this.timeIndex,
    this.analysisDate,
    this.image,
    this.utcDatetime,
    this.localDatetime,
  });

  factory Cuaca.fromJson(String str) => Cuaca.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cuaca.fromMap(Map<String, dynamic> json) => Cuaca(
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        t: json["t"],
        tcc: json["tcc"],
        weather: json["weather"],
        weatherDesc: json["weather_desc"],
        weatherDescEn: json["weather_desc_en"],
        wdDeg: json["wd_deg"],
        wd: json["wd"],
        wdTo: json["wd_to"],
        ws: json["ws"]?.toDouble(),
        hu: json["hu"],
        vs: json["vs"],
        vsText: json["vs_text"],
        timeIndex: json["time_index"],
        analysisDate: json["analysis_date"] == null
            ? null
            : DateTime.parse(json["analysis_date"]),
        image: json["image"],
        utcDatetime: json["utc_datetime"] == null
            ? null
            : DateTime.parse(json["utc_datetime"]),
        localDatetime: json["local_datetime"] == null
            ? null
            : DateTime.parse(json["local_datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "datetime": datetime?.toIso8601String(),
        "t": t,
        "tcc": tcc,
        "weather": weather,
        "weather_desc": weatherDesc,
        "weather_desc_en": weatherDescEn,
        "wd_deg": wdDeg,
        "wd": wd,
        "wd_to": wdTo,
        "ws": ws,
        "hu": hu,
        "vs": vs,
        "vs_text": vsText,
        "time_index": timeIndex,
        "analysis_date": analysisDate?.toIso8601String(),
        "image": image,
        "utc_datetime": utcDatetime?.toIso8601String(),
        "local_datetime": localDatetime?.toIso8601String(),
      };
}

class Lokasi {
  String? adm1;
  String? adm2;
  String? adm3;
  String? adm4;
  String? provinsi;
  String? kotkab;
  String? kecamatan;
  String? desa;
  double? lon;
  double? lat;
  String? timezone;
  String? type;
  String? kota;

  Lokasi({
    this.adm1,
    this.adm2,
    this.adm3,
    this.adm4,
    this.provinsi,
    this.kotkab,
    this.kecamatan,
    this.desa,
    this.lon,
    this.lat,
    this.timezone,
    this.type,
    this.kota,
  });

  factory Lokasi.fromJson(String str) => Lokasi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lokasi.fromMap(Map<String, dynamic> json) => Lokasi(
        adm1: json["adm1"],
        adm2: json["adm2"],
        adm3: json["adm3"],
        adm4: json["adm4"],
        provinsi: json["provinsi"],
        kotkab: json["kotkab"],
        kecamatan: json["kecamatan"],
        desa: json["desa"],
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        timezone: json["timezone"],
        type: json["type"],
        kota: json["kota"],
      );

  Map<String, dynamic> toMap() => {
        "adm1": adm1,
        "adm2": adm2,
        "adm3": adm3,
        "adm4": adm4,
        "provinsi": provinsi,
        "kotkab": kotkab,
        "kecamatan": kecamatan,
        "desa": desa,
        "lon": lon,
        "lat": lat,
        "timezone": timezone,
        "type": type,
        "kota": kota,
      };
}
