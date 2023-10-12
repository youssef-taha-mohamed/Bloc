import 'package:blok/business_logic_layer/cubit/characters_cubit.dart';
import 'package:blok/constants/mycolors.dart';
import 'package:blok/data/models/characters.dart';
import 'package:blok/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final _searchTextControlar = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: const Text(
          "Characters",
          style: TextStyle(
            color: MyColors.myGray,
          ),
        ),
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextControlar,
      cursorColor: Colors.grey[200],
      decoration: InputDecoration(
        hintText: "Find a character....",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGray, fontSize: 18.0),
      ),
      style: TextStyle(color: MyColors.myGray, fontSize: 18.0),
      onChanged: (searchedCharacter) {
        addSearchedForItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGray,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGray,
            )),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextControlar.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (contxt, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGray,
        child: Column(children: [
          buildCharactersList(),
        ]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allCharacters.length,
      itemBuilder: (ctx, index) {
        return CharactersItem(
          character: allCharacters[index],
        );
      },
    );
  }
}
