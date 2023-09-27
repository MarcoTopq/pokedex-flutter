import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:sprout/detail_pokemon.dart';
import 'dart:convert';

import 'package:sprout/pokemon_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PokemonListScreen(),
    );
  }
}

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  List<dynamic> pokemonList = [];
  List<PokemonModel> pokemonDetailList = [];
  List<PokemonModel> filteredPokemonList = [];
  ScrollController scrollController = ScrollController();
  String nextpage = '';
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData("https://pokeapi.co/api/v2/pokemon?offset=0&limit=20");
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Pengguna telah mencapai bagian bawah daftar
      log('Anda telah mencapai bagian bawah daftar.');
      // Lakukan tindakan sesuai kebutuhan
      fetchData(nextpage);
    }

    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      // Pengguna telah mencapai bagian atas daftar
      log('Anda telah mencapai bagian atas daftar.');
      // Lakukan tindakan sesuai kebutuhan
    }
  }

  Future<void> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        nextpage = data["next"];
        pokemonList = data['results'];
      });

      for (var e in data['results']) {
        await fetchPokemonDetail(e['url']);
      }
    }
  }

  Future<void> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString());
      final pokemonDetail = PokemonModel.fromJson(data);
      pokemonDetailList.add(pokemonDetail);
      filteredPokemonList.add(pokemonDetail);
      log(pokemonDetailList.length.toString());
      setState(() {});
    }
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

  void filterPokemonList(String query) {
    final filteredList = pokemonDetailList.where((pokemon) {
      final name = pokemon.name!.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredPokemonList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokedex',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        actions: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/pokeball3.png',
              width: 100,
            ),
          ),
        ],
        backgroundColor: Colors.deepPurple.shade900,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                filterPokemonList(query);
              },
              decoration: const InputDecoration(
                labelText: 'Search Pokemon',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              controller: scrollController,
              itemCount: filteredPokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = filteredPokemonList[index];
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPokemon(pokemon: pokemon),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.deepPurple.shade900,
                      // baseColor(pokemon.types![0].type!.name.toString()),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Color.fromARGB(255, 194, 194, 194),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 100),
                          alignment: Alignment.bottomCenter,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            // image: const DecorationImage(
                            //   image: AssetImage(
                            //     'assets/pokeball.png',
                            //   ),
                            // ),
                            color: baseColor(
                                pokemon.types![0].type!.name.toString()),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/pokeball.png',
                            width: 30,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.network(
                              pokemon.sprites!.other!.dreamWorld!.frontDefault
                                  .toString(),
                              width: 100,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                pokemon.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: pokemon.types!
                                    .map((e) => Container(
                                        margin: const EdgeInsets.all(5),
                                        width: 50,
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
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
