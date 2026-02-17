// Country Response
class CountryResponse {
  final String status;
  final List<Country> data;

  CountryResponse({
    required this.status,
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Country.fromJson(e))
              .toList() ??
          [],
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class Country {
  final int id;
  final String name;
  final String alpha2;
  final String alpha3;
  final String? dialCode;
  final String hasOffice;

  Country({
    required this.id,
    required this.name,
    required this.alpha2,
    required this.alpha3,
    this.dialCode,
    required this.hasOffice,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      alpha2: json['alpha2'] ?? '',
      alpha3: json['alpha3'] ?? '',
      dialCode: json['dial_code']?.toString(),
      hasOffice: json['hasOffice']?.toString() ?? '0',
    );
  }

  String get capitalizedName {
    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  bool get hasOfficeBool => hasOffice == '1';
}

// State Response
class StateResponse {
  final String status;
  final List<StateModel> data;

  StateResponse({
    required this.status,
    required this.data,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    return StateResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => StateModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class StateModel {
  final int id;
  final String name;
  final String code;
  final String countryId;

  StateModel({
    required this.id,
    required this.name,
    required this.code,
    required this.countryId,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      countryId: json['country_id']?.toString() ?? '',
    );
  }
}

// LGA Response
class LgaResponse {
  final String status;
  final List<Lga> data;

  LgaResponse({
    required this.status,
    required this.data,
  });

  factory LgaResponse.fromJson(Map<String, dynamic> json) {
    return LgaResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Lga.fromJson(e))
              .toList() ??
          [],
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class Lga {
  final int id;
  final String name;
  final String code;
  final String active;
  final String regionId;

  Lga({
    required this.id,
    required this.name,
    required this.code,
    required this.active,
    required this.regionId,
  });

  factory Lga.fromJson(Map<String, dynamic> json) {
    return Lga(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      active: json['active']?.toString() ?? '1',
      regionId: json['region_id']?.toString() ?? '',
    );
  }

  bool get isActive => active == '1';
}