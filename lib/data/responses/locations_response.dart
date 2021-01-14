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
  String governorate;
  String createdAt;
  String updatedAt;
  List<City> cities;

  Location(
      {this.id, this.governorate, this.createdAt, this.updatedAt, this.cities});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorate = json['governorate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['governorate'] = this.governorate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int id;
  String city;
  int govId;
  String createdAt;
  String updatedAt;

  City({this.id, this.city, this.govId, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    govId = json['gov_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['gov_id'] = this.govId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
