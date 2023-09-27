// To parse this JSON data, do
//
//     final speciesModel = speciesModelFromJson(jsonString);

import 'dart:convert';

SpeciesModel speciesModelFromJson(String str) =>
    SpeciesModel.fromJson(json.decode(str));

String speciesModelToMap(SpeciesModel data) => json.encode(data.toMap());

class SpeciesModel {
  final int? baseHappiness;
  final int? captureRate;
  final Color? color;
  final List<Color>? eggGroups;
  final EvolutionChain? evolutionChain;
  final Color? evolvesFromSpecies;
  final List<FlavorTextEntry>? flavorTextEntries;
  final List<dynamic>? formDescriptions;
  final bool? formsSwitchable;
  final int? genderRate;
  final List<Genus>? genera;
  final Color? generation;
  final Color? growthRate;
  final Color? habitat;
  final bool? hasGenderDifferences;
  final int? hatchCounter;
  final int? id;
  final bool? isBaby;
  final bool? isLegendary;
  final bool? isMythical;
  final String? name;
  final List<Name>? names;
  final int? order;
  final List<PalParkEncounter>? palParkEncounters;
  final List<PokedexNumber>? pokedexNumbers;
  final Color? shape;
  final List<Variety>? varieties;

  SpeciesModel({
    this.baseHappiness,
    this.captureRate,
    this.color,
    this.eggGroups,
    this.evolutionChain,
    this.evolvesFromSpecies,
    this.flavorTextEntries,
    this.formDescriptions,
    this.formsSwitchable,
    this.genderRate,
    this.genera,
    this.generation,
    this.growthRate,
    this.habitat,
    this.hasGenderDifferences,
    this.hatchCounter,
    this.id,
    this.isBaby,
    this.isLegendary,
    this.isMythical,
    this.name,
    this.names,
    this.order,
    this.palParkEncounters,
    this.pokedexNumbers,
    this.shape,
    this.varieties,
  });

  factory SpeciesModel.fromJson(Map<String, dynamic> json) => SpeciesModel(
        baseHappiness: json["base_happiness"],
        captureRate: json["capture_rate"],
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
        eggGroups: json["egg_groups"] == null
            ? []
            : List<Color>.from(
                json["egg_groups"]!.map((x) => Color.fromJson(x))),
        evolutionChain: json["evolution_chain"] == null
            ? null
            : EvolutionChain.fromJson(json["evolution_chain"]),
        evolvesFromSpecies: json["evolves_from_species"] == null
            ? null
            : Color.fromJson(json["evolves_from_species"]),
        flavorTextEntries: json["flavor_text_entries"] == null
            ? []
            : List<FlavorTextEntry>.from(json["flavor_text_entries"]!
                .map((x) => FlavorTextEntry.fromJson(x))),
        formDescriptions: json["form_descriptions"] == null
            ? []
            : List<dynamic>.from(json["form_descriptions"]!.map((x) => x)),
        formsSwitchable: json["forms_switchable"],
        genderRate: json["gender_rate"],
        genera: json["genera"] == null
            ? []
            : List<Genus>.from(json["genera"]!.map((x) => Genus.fromJson(x))),
        generation: json["generation"] == null
            ? null
            : Color.fromJson(json["generation"]),
        growthRate: json["growth_rate"] == null
            ? null
            : Color.fromJson(json["growth_rate"]),
        habitat:
            json["habitat"] == null ? null : Color.fromJson(json["habitat"]),
        hasGenderDifferences: json["has_gender_differences"],
        hatchCounter: json["hatch_counter"],
        id: json["id"],
        isBaby: json["is_baby"],
        isLegendary: json["is_legendary"],
        isMythical: json["is_mythical"],
        name: json["name"],
        names: json["names"] == null
            ? []
            : List<Name>.from(json["names"]!.map((x) => Name.fromJson(x))),
        order: json["order"],
        palParkEncounters: json["pal_park_encounters"] == null
            ? []
            : List<PalParkEncounter>.from(json["pal_park_encounters"]!
                .map((x) => PalParkEncounter.fromJson(x))),
        pokedexNumbers: json["pokedex_numbers"] == null
            ? []
            : List<PokedexNumber>.from(
                json["pokedex_numbers"]!.map((x) => PokedexNumber.fromJson(x))),
        shape: json["shape"] == null ? null : Color.fromJson(json["shape"]),
        varieties: json["varieties"] == null
            ? []
            : List<Variety>.from(
                json["varieties"]!.map((x) => Variety.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "base_happiness": baseHappiness,
        "capture_rate": captureRate,
        "color": color?.toMap(),
        "egg_groups": eggGroups == null
            ? []
            : List<dynamic>.from(eggGroups!.map((x) => x.toMap())),
        "evolution_chain": evolutionChain?.toMap(),
        "evolves_from_species": evolvesFromSpecies?.toMap(),
        "flavor_text_entries": flavorTextEntries == null
            ? []
            : List<dynamic>.from(flavorTextEntries!.map((x) => x.toMap())),
        "form_descriptions": formDescriptions == null
            ? []
            : List<dynamic>.from(formDescriptions!.map((x) => x)),
        "forms_switchable": formsSwitchable,
        "gender_rate": genderRate,
        "genera": genera == null
            ? []
            : List<dynamic>.from(genera!.map((x) => x.toMap())),
        "generation": generation?.toMap(),
        "growth_rate": growthRate?.toMap(),
        "habitat": habitat?.toMap(),
        "has_gender_differences": hasGenderDifferences,
        "hatch_counter": hatchCounter,
        "id": id,
        "is_baby": isBaby,
        "is_legendary": isLegendary,
        "is_mythical": isMythical,
        "name": name,
        "names": names == null
            ? []
            : List<dynamic>.from(names!.map((x) => x.toMap())),
        "order": order,
        "pal_park_encounters": palParkEncounters == null
            ? []
            : List<dynamic>.from(palParkEncounters!.map((x) => x.toMap())),
        "pokedex_numbers": pokedexNumbers == null
            ? []
            : List<dynamic>.from(pokedexNumbers!.map((x) => x.toMap())),
        "shape": shape?.toMap(),
        "varieties": varieties == null
            ? []
            : List<dynamic>.from(varieties!.map((x) => x.toMap())),
      };
}

class Color {
  final String? name;
  final String? url;

  Color({
    this.name,
    this.url,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class EvolutionChain {
  final String? url;

  EvolutionChain({
    this.url,
  });

  factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
      };
}

class FlavorTextEntry {
  final String? flavorText;
  final Color? language;
  final Color? version;

  FlavorTextEntry({
    this.flavorText,
    this.language,
    this.version,
  });

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) =>
      FlavorTextEntry(
        flavorText: json["flavor_text"],
        language:
            json["language"] == null ? null : Color.fromJson(json["language"]),
        version:
            json["version"] == null ? null : Color.fromJson(json["version"]),
      );

  Map<String, dynamic> toMap() => {
        "flavor_text": flavorText,
        "language": language?.toMap(),
        "version": version?.toMap(),
      };
}

class Genus {
  final String? genus;
  final Color? language;

  Genus({
    this.genus,
    this.language,
  });

  factory Genus.fromJson(Map<String, dynamic> json) => Genus(
        genus: json["genus"],
        language:
            json["language"] == null ? null : Color.fromJson(json["language"]),
      );

  Map<String, dynamic> toMap() => {
        "genus": genus,
        "language": language?.toMap(),
      };
}

class Name {
  final Color? language;
  final String? name;

  Name({
    this.language,
    this.name,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        language:
            json["language"] == null ? null : Color.fromJson(json["language"]),
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "language": language?.toMap(),
        "name": name,
      };
}

class PalParkEncounter {
  final Color? area;
  final int? baseScore;
  final int? rate;

  PalParkEncounter({
    this.area,
    this.baseScore,
    this.rate,
  });

  factory PalParkEncounter.fromJson(Map<String, dynamic> json) =>
      PalParkEncounter(
        area: json["area"] == null ? null : Color.fromJson(json["area"]),
        baseScore: json["base_score"],
        rate: json["rate"],
      );

  Map<String, dynamic> toMap() => {
        "area": area?.toMap(),
        "base_score": baseScore,
        "rate": rate,
      };
}

class PokedexNumber {
  final int? entryNumber;
  final Color? pokedex;

  PokedexNumber({
    this.entryNumber,
    this.pokedex,
  });

  factory PokedexNumber.fromJson(Map<String, dynamic> json) => PokedexNumber(
        entryNumber: json["entry_number"],
        pokedex:
            json["pokedex"] == null ? null : Color.fromJson(json["pokedex"]),
      );

  Map<String, dynamic> toMap() => {
        "entry_number": entryNumber,
        "pokedex": pokedex?.toMap(),
      };
}

class Variety {
  final bool? isDefault;
  final Color? pokemon;

  Variety({
    this.isDefault,
    this.pokemon,
  });

  factory Variety.fromJson(Map<String, dynamic> json) => Variety(
        isDefault: json["is_default"],
        pokemon:
            json["pokemon"] == null ? null : Color.fromJson(json["pokemon"]),
      );

  Map<String, dynamic> toMap() => {
        "is_default": isDefault,
        "pokemon": pokemon?.toMap(),
      };
}
