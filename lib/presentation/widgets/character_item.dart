import 'package:blok/constants/mycolors.dart';
import 'package:blok/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharactersItem extends StatelessWidget {
  final Character character;

  const CharactersItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: GridTile(
        child: Container(
          color: MyColors.myGray,
          child: character.image.isNotEmpty
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: character.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/images/placeholder.png'),
        ),
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text(
            "${character.name}",
            style: const TextStyle(
              height: 1.3,
              fontSize: 16,
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
