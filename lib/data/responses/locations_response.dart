import 'package:tera/a_storage/local_storage.dart';

class LocationsResponse {
  bool status;
  String message;
  List<Location> locations;

  LocationsResponse({this.status, this.message, this.locations});

  LocationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      locations = new List<Location>();
      json['data'].forEach((v) {
        locations.add(new Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.locations != null) {
      data['data'] = this.locations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  int id;
  String nameEn;
  String nameAr;
  List<City> cities;

  Location({this.id, this.nameEn, this.nameAr, this.cities});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['governorate'];
    nameAr = json['governorateAr'];
    if (json['cities'] != null) {
      cities = new List<City>();
      json['cities'].forEach((v) {
        cities.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['governorate'] = this.nameEn;
    data['governorateAr'] = this.nameAr;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String get displayName => LocalStorage().isArabicLanguage()
      ? (nameAr == null ? '' : nameAr)
      : (nameEn == null ? '' : nameEn);
}

class City {
  int id;
  String nameEn;
  String nameAr;
  int locationId;

  City({
    this.id,
    this.nameEn,
    this.nameAr,
    this.locationId,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['city'];
    nameAr = json['cityAr'];
    locationId = json['gov_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.nameEn;
    data['cityAr'] = this.nameAr;
    data['gov_id'] = this.locationId;
    return data;
  }

  String get displayName => LocalStorage().isArabicLanguage()
      ? (nameAr == null ? '' : nameAr)
      : (nameEn == null ? '' : nameEn);
}
