import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business%20logic/cubit/breaking_bad_cubit.dart';
import '../../constant/myColor.dart';
import '../../data/models/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({Key? key, required this.character}) : super(key: key);
  final CharactersModel character;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BreakingBadCubit>(context).getQuote(character.name);
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.myGrey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: MyColor.myGrey,
              expandedHeight: 80.h,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  character.nickname,
                ),
                background: Image.network(
                  character.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  characterDetails(
                      'Jop', character.occupation.join(' / '), 87.w),
                  characterDetails('Appeared In', character.category, 68.w),
                  characterDetails(
                      'Seasons', character.appearance.join(' / '), 75.w),
                  characterDetails('Status', character.status, 80.w),
                  character.betterCallSaulAppearance.isEmpty
                      ? const SizedBox()
                      : characterDetails('Better Call Saul Seasons',
                          character.betterCallSaulAppearance.join(' / '), 40.w),
                  characterDetails('Actor / Actress', character.name, 60.w),
                  characterDetails('Portrayed', character.portrayed, 72.w),
                  characterDetails('Birthday', character.birthday, 77.w),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<BreakingBadCubit, BreakingBadState>(
                    builder: (context, state) {
                      return checkQuoteAreLoaded(state);
                    },
                  ),
                  const SizedBox(
                    height: 400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget characterDetails(
    String title,
    String description,
    double endPoint,
  ) {
    return Container(
      padding: EdgeInsets.only(
        top: 1.h,
        left: 5.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: [
              TextSpan(
                text: '$title : ',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: MyColor.myWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: description,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: MyColor.myWhite,
                  // fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
          Divider(
            color: MyColor.myYellow,
            thickness: 2,
            endIndent: endPoint,
          )
        ],
      ),
    );
  }

  Widget checkQuoteAreLoaded(state) {
    if (state is QuotesLoaded) {
      return animatedTextOrLoading(state);
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: MyColor.myYellow,
        ),
      );
    }
  }

  Widget animatedTextOrLoading(state) {
    var quotes = (state).quotes;

    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);

      return Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(
            shadows: const [
              Shadow(
                blurRadius: 6.0,
                color: MyColor.myYellow,
              ),
            ],
            fontSize: 15.sp,
            color: MyColor.myYellow,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
            repeatForever: true,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
