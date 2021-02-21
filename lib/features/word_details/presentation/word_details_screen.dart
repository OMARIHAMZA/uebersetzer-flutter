import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/widgets/bottom_curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/core/widgets/top_curved_widget.dart';
import 'package:uebersetzer/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:uebersetzer/core/utils/extensions.dart';
import 'package:uebersetzer/main.dart';

import 'widgets/word_action_button.dart';

class WordDetailsScreen extends StatefulWidget {
  final Word word;

  WordDetailsScreen({@required this.word});

  @override
  _WordDetailsScreenState createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  Word word;
  int favoriteId;

  @override
  void initState() {
    word = widget.word;
    favoriteId = word.favoriteId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        mTitle: '',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BottomCurvedWidget(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                word.word,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                word.getDescription(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WordActionButton(
                    title: getL10nInstance(context).listen,
                    iconData: Icons.volume_up,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildFavoriteButton(),
                  SizedBox(
                    width: 10.0,
                  ),
                  WordActionButton(
                    title: getL10nInstance(context).copy,
                    iconData: Icons.copy,
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: word.getCopyDetails()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          )),
          TopCurvedWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 15.0, right: 15.0, bottom: 5.0),
                  child: Text(
                    getL10nInstance(context).meanings.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[800]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Wrap(
                      spacing: 6.0,
                      children: List<Widget>.generate(
                          word.meaning.length,
                          (index) => Chip(
                                label: Text(word.meaning[index]),
                                backgroundColor: Colors.grey[200],
                                elevation: 3.0,
                              )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getL10nInstance(context).localDataCopyRights,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 12.0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder<FavoritesBloc, FavoritesState> _buildFavoriteButton() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoriteAdded) {
          favoriteId = state.id;
        } else if (state is FavoriteRemoved) {
          favoriteId = 0;
        }
        return WordActionButton(
          title: favoriteId == 0 ? getL10nInstance(context).save : getL10nInstance(context).remove,
          iconData:
              favoriteId == 0 ? Icons.star_border : Icons.star_outlined,
          onPressed: () {
            if (favoriteId == 0) {
              BlocProvider.of<FavoritesBloc>(context)
                  .dispatch(AddFavoriteEvent(word: word));
            } else {
              BlocProvider.of<FavoritesBloc>(context)
                  .dispatch(RemoveFavoriteEvent(id: favoriteId));
            }
          },
        );
      },
    );
  }
}
