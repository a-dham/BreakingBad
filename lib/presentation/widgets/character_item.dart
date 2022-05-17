import '../../constant/myColor.dart';
import '../../constant/strings.dart';
import '../../data/models/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);
  final CharactersModel character;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, charactersDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColor.myGrey,
              child: character.img.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      // height: double.infinity,
                      // width: double.infinity,
                      placeholderCacheHeight: 20,
                      placeholderCacheWidth: 20,
                      placeholder: 'assets/images/loading-gray.gif',
                      image: character.img,
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(''),
            ),
          ),
          footer: Container(
            padding: EdgeInsets.symmetric(
              vertical: 2.h,
            ),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              character.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColor.myWhite,
                fontSize: 10.sp,
                height: 1.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
