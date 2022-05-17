import 'package:flutter_offline/flutter_offline.dart';

import '../../business%20logic/cubit/breaking_bad_cubit.dart';
import '../../constant/myColor.dart';
import '../../data/models/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharactersModel> allCharacter = [];

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<BreakingBadCubit>(context).checkInterNet();
    BlocProvider.of<BreakingBadCubit>(context).getAllCharacter();
  }

  TextEditingController textEditingController = TextEditingController();
  bool isSearched = false;
  List<CharactersModel> searchedList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: isSearched
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearched = false;
                      textEditingController.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: MyColor.myGrey,
                  ),
                )
              : null,
          title: isSearched
              ? null
              : Text(
                  'Character',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            ...widgetsForSearch(),
          ],
          backgroundColor: MyColor.myYellow,
          elevation: 0,
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            context,
            connectivity,
            child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;

            if (connected) {
              return buildBlocWidget();
            } else {
              return Center(
                child: Image.asset('assets/images/offline.png'),
              );
            }
          },
          child: showLoadingIndicator(),
        ),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<BreakingBadCubit, BreakingBadState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacter = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColor.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return Container(
      color: MyColor.myGrey,
      child: Column(
        children: [
          buildCharacterList(),
        ],
      ),
    );
  }

  Widget buildCharacterList() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1 / 1.5,
        ),
        itemCount: textEditingController.text.isEmpty
            ? allCharacter.length
            : searchedList.length,
        // shrinkWrap: true,
        // physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return CharacterItem(
            character: textEditingController.text.isEmpty
                ? allCharacter[index]
                : searchedList[index],
          );
        },
      ),
    );
  }

  List<Widget> widgetsForSearch() {
    if (isSearched == true) {
      return [
        SizedBox(
          width: 80.w,
          child: TextField(
            controller: textEditingController,
            onChanged: (inputs) {
              searchedList = allCharacter
                  .where(
                    (character) =>
                        character.name.toLowerCase().contains(inputs),
                  )
                  .toList();

              setState(() {});
            },
            decoration: const InputDecoration(
                hintText: 'search...',
                hintStyle: TextStyle(
                  color: MyColor.myGrey,
                )),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isSearched = false;
              textEditingController.clear();
            });
          },
          icon: const Icon(
            Icons.clear,
            color: MyColor.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            setState(() {
              isSearched = true;
            });
          },
          icon: const Icon(
            Icons.search,
            color: MyColor.myGrey,
          ),
        ),
      ];
    }
  }
}
