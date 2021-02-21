import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/navigation/bottom_navigation.dart';
import 'package:uebersetzer/core/utils/utils.dart';
import 'package:uebersetzer/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:uebersetzer/features/search/presentation/widgets/section_title.dart';
import 'package:uebersetzer/features/search/presentation/widgets/words_list/word_list_item.dart';
import 'package:uebersetzer/features/word_details/presentation/word_details_screen.dart';

class FavoritesSection extends StatefulWidget {
  @override
  _FavoritesSectionState createState() => _FavoritesSectionState();
}

class _FavoritesSectionState extends State<FavoritesSection> {
  FavoritesBloc favoritesBloc;

  @override
  void initState() {
    favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    favoritesBloc.dispatch(GetFavoritesEvent());
    super.initState();
  }

  @override
  void dispose() {
    favoritesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
            title: 'Gespeicherte Wörter',
            iconData: Icons.star,
            onPressed: () {
              BottomNavigationBar bottomNavBar = bottomGlobalKey.currentWidget;
              bottomNavBar.onTap(1);
            }),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey[200],
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
            if (state is FavoritesLoading) {
              return CircularProgressIndicator();
            } else if (state is FavoritesLoaded) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    state.favorites.length > 5 ? 5 : state.favorites.length,
                separatorBuilder: (context, index) => Divider(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return WordsListItem(
                      word: state.favorites[index],
                      onTap: (item) {
                        navigate(context, WordDetailsScreen(word: item));
                      });
                },
              );
            } else if (state is FavoritesEmpty) {
              return Container();
            }
            return Container();
          }),
        ),
      ],
    );
  }
}
