// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToMap(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LocationModel {
  final LocationArea? locationArea;
  final List<VersionDetail>? versionDetails;

  LocationModel({
    this.locationArea,
    this.versionDetails,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        locationArea: json["location_area"] == null
            ? null
            : LocationArea.fromJson(json["location_area"]),
        versionDetails: json["version_details"] == null
            ? []
            : List<VersionDetail>.from(
                json["version_details"]!.map((x) => VersionDetail.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "location_area": locationArea?.toMap(),
        "version_details": versionDetails == null
            ? []
            : List<dynamic>.from(versionDetails!.map((x) => x.toMap())),
      };
}

class LocationArea {
  final String? name;
  final String? url;

  LocationArea({
    this.name,
    this.url,
  });

  factory LocationArea.fromJson(Map<String, dynamic> json) => LocationArea(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class VersionDetail {
  final List<EncounterDetail>? encounterDetails;
  final int? maxChance;
  final LocationArea? version;

  VersionDetail({
    this.encounterDetails,
    this.maxChance,
    this.version,
  });

  factory VersionDetail.fromJson(Map<String, dynamic> json) => VersionDetail(
        encounterDetails: json["encounter_details"] == null
            ? []
            : List<EncounterDetail>.from(json["encounter_details"]!
                .map((x) => EncounterDetail.fromJson(x))),
        maxChance: json["max_chance"],
        version: json["version"] == null
            ? null
            : LocationArea.fromJson(json["version"]),
      );

  Map<String, dynamic> toMap() => {
        "encounter_details": encounterDetails == null
            ? []
            : List<dynamic>.from(encounterDetails!.map((x) => x.toMap())),
        "max_chance": maxChance,
        "version": version?.toMap(),
      };
}

class EncounterDetail {
  final int? chance;
  final List<LocationArea>? conditionValues;
  final int? maxLevel;
  final LocationArea? method;
  final int? minLevel;

  EncounterDetail({
    this.chance,
    this.conditionValues,
    this.maxLevel,
    this.method,
    this.minLevel,
  });

  factory EncounterDetail.fromJson(Map<String, dynamic> json) =>
      EncounterDetail(
        chance: json["chance"],
        conditionValues: json["condition_values"] == null
            ? []
            : List<LocationArea>.from(
                json["condition_values"]!.map((x) => LocationArea.fromJson(x))),
        maxLevel: json["max_level"],
        method: json["method"] == null
            ? null
            : LocationArea.fromJson(json["method"]),
        minLevel: json["min_level"],
      );

  Map<String, dynamic> toMap() => {
        "chance": chance,
        "condition_values": conditionValues == null
            ? []
            : List<dynamic>.from(conditionValues!.map((x) => x.toMap())),
        "max_level": maxLevel,
        "method": method?.toMap(),
        "min_level": minLevel,
      };
}
