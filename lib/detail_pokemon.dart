import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout/evolution_model.dart';
import 'package:sprout/location_model.dart';
import 'package:sprout/pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'package:sprout/species_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailPokemon extends StatefulWidget {
  const DetailPokemon({super.key, required this.pokemon});
  final PokemonModel pokemon;
  @override
  State<DetailPokemon> createState() => _DetailPokemonState();
}

class _DetailPokemonState extends State<DetailPokemon> {
  EvolutionModel evolutionModel = EvolutionModel();
  List<LocationModel> locationModel = [];
  SpeciesModel speciesModel = SpeciesModel();

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    await fetchDataLocation();
    await fetchDataSpecies();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  baseColor(String primaryType) {
    switch (primaryType) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'bug':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  baseColorOpacity(String primaryType) {
    switch (primaryType) {
      case 'grass':
        return Colors.green.withOpacity(0.5);
      case 'fire':
        return Colors.red.withOpacity(0.5);
      case 'water':
        return Colors.blue.withOpacity(0.5);
      case 'bug':
        return Colors.brown.withOpacity(0.5);
      default:
        return Colors.grey.withOpacity(0.5);
    }
  }

  getId(String url) {
    // Mencari indeks awal "pokemon-species/" dalam URL
    int startIndex =
        url.indexOf("pokemon-species/") + "pokemon-species/".length;

    // Mencari indeks akhir setelah tanda "/"
    int endIndex = url.indexOf("/", startIndex);

    // Mengambil substring yang berisi ID
    String id = url.substring(startIndex, endIndex);
    return id;
  }

  Future<void> fetchDataEvolution(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString());

      setState(() {
        evolutionModel = EvolutionModel.fromJson(data);
      });
    }
  }

  Future<void> fetchDataLocation() async {
    final response = await http
        .get(Uri.parse(widget.pokemon.locationAreaEncounters.toString()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString());
      setState(() {
        //  final locationData = LocationModel.fromJson(data);
        for (var e in data) {
          locationModel.add(LocationModel.fromJson(e));
        }
      });
    }
  }

  Future<void> fetchDataSpecies() async {
    final response =
        await http.get(Uri.parse(widget.pokemon.species!.url.toString()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString());

      setState(() {
        speciesModel = SpeciesModel.fromJson(data);
        fetchDataEvolution(speciesModel.evolutionChain!.url.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        widget.pokemon.stats![0].stat!.name.toString(),
        widget.pokemon.stats![0].baseStat!.toInt(),
      ),
      ChartData(
        widget.pokemon.stats![1].stat!.name.toString(),
        widget.pokemon.stats![1].baseStat!.toInt(),
      ),
      ChartData(
        widget.pokemon.stats![2].stat!.name.toString(),
        widget.pokemon.stats![2].baseStat!.toInt(),
      ),
      ChartData(
        widget.pokemon.stats![3].stat!.name.toString(),
        widget.pokemon.stats![3].baseStat!.toInt(),
      ),
      ChartData(
        widget.pokemon.stats![4].stat!.name.toString(),
        widget.pokemon.stats![4].baseStat!.toInt(),
      ),
      ChartData(
        widget.pokemon.stats![5].stat!.name.toString(),
        widget.pokemon.stats![5].baseStat!.toInt(),
      ),
    ];
    return Scaffold(
      body: isLoading == false
          ? Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        color: baseColorOpacity(
                            widget.pokemon.types![0].type!.name.toString()),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back)),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.pokemon.name.toString(),
                                    style: TextStyle(
                                        color: Colors.deepPurple.shade900,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    '#${widget.pokemon.id}',
                                    style: TextStyle(
                                        color: Colors.deepPurple.shade900,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: SvgPicture.network(
                              widget.pokemon.sprites!.other!.dreamWorld!
                                  .frontDefault
                                  .toString(),
                              width: 200,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.pokemon.types!
                              .map((e) => Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 80,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.deepPurple.shade200,
                                  ),
                                  child: Center(
                                    child: Text(
                                      e.type!.name.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    widget.pokemon.species!.name.toString(),
                                    style: TextStyle(
                                        color: baseColor(widget
                                            .pokemon.types![0].type!.name
                                            .toString()),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Species',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              VerticalDivider(
                                width: 2,
                                thickness: 2,
                                color: baseColor(widget
                                    .pokemon.types![0].type!.name
                                    .toString()),
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.pokemon.height.toString(),
                                    style: TextStyle(
                                        color: baseColor(widget
                                            .pokemon.types![0].type!.name
                                            .toString()),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Height',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              VerticalDivider(
                                width: 2,
                                thickness: 2,
                                color: baseColor(widget
                                    .pokemon.types![0].type!.name
                                    .toString()),
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.pokemon.weight.toString(),
                                    style: TextStyle(
                                        color: baseColor(widget
                                            .pokemon.types![0].type!.name
                                            .toString()),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Weight',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  speciesModel.generation!.name.toString(),
                                  style: TextStyle(
                                      color: baseColor(widget
                                          .pokemon.types![0].type!.name
                                          .toString()),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Generation',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  speciesModel.habitat!.name.toString(),
                                  style: TextStyle(
                                      color: baseColor(widget
                                          .pokemon.types![0].type!.name
                                          .toString()),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Habitat',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            'Evolution',
                            style: TextStyle(
                                color: baseColor(widget
                                    .pokemon.types![0].type!.name
                                    .toString()),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.network(
                                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${getId(evolutionModel.chain!.species!.url.toString())}.svg',
                                      width: 70,
                                    )),
                                Text(
                                  evolutionModel.chain!.species!.name
                                      .toString(),
                                  style: TextStyle(
                                      color: baseColor(widget
                                          .pokemon.types![0].type!.name
                                          .toString()),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Move',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.network(
                                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${getId(evolutionModel.chain!.evolvesTo![0].species!.url.toString())}.svg',
                                      width: 70,
                                    )),
                                Text(
                                  evolutionModel
                                      .chain!.evolvesTo![0].species!.name
                                      .toString(),
                                  style: TextStyle(
                                      color: baseColor(widget
                                          .pokemon.types![0].type!.name
                                          .toString()),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Move',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.network(
                                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${getId(evolutionModel.chain!.evolvesTo![0].evolvesTo![0].species!.url.toString())}.svg',
                                      width: 70,
                                    )),
                                Text(
                                  evolutionModel.chain!.evolvesTo![0]
                                      .evolvesTo![0].species!.name
                                      .toString(),
                                  style: TextStyle(
                                      color: baseColor(widget
                                          .pokemon.types![0].type!.name
                                          .toString()),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Move',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            child: SfCartesianChart(
                                title: ChartTitle(
                                  text: 'Base Stats',
                                  textStyle: TextStyle(
                                      color: baseColor(widget
                                          .pokemon.types![0].type!.name
                                          .toString()),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
                              StackedBarSeries<ChartData, String>(
                                  dataSource: chartData,
                                  color: baseColor(widget
                                      .pokemon.types![0].type!.name
                                      .toString()),
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true)),
                            ]))
                      ],
                    ),
                  ),
                )
              ],
            )
          : Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/pokeball3.png',
                  width: 250,
                ),
              ),
            ),
    );
  }
}

class ChartData {
  final String x;
  final num y;
  ChartData(
    this.x,
    this.y,
  );
}
