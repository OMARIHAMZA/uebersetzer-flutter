import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/utils/utils.dart';
import 'package:uebersetzer/core/widgets/bottom_curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/core/widgets/top_curved_widget.dart';
import 'package:uebersetzer/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_field.dart';
import 'package:uebersetzer/features/search/presentation/widgets/words_list/word_list_item.dart';
import 'package:uebersetzer/features/word_details/presentation/word_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    _favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    super.initState();
    _dispatchGetFavorites();
  }

  @override
  void dispose() {
    _favoritesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          BottomCurvedWidget(
            child: SearchField(
              onSubmitted: (value) {
                // TODO:: FILTER LIST
              },
            ),
          ),
          TopCurvedWidget(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  buildBlocBuilder(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  BlocBuilder<FavoritesBloc, FavoritesState> buildBlocBuilder() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
      if (state is FavoritesInitial || state is FavoritesLoading) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        );
      } else if (state is FavoritesLoaded) {
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return WordsListItem(
                  word: state.favorites[index],
                  onTap: (item) {
                    navigate(context, WordDetailsScreen(word: item));
                  });
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.favorites.length,
          ),
        );
      } else if (state is FavoritesEmpty) {
        return Text('Nothing is here yet');
      } else if (state is FavoriteAdded) {
        _dispatchGetFavorites();
      } else if (state is FavoriteRemoved) {
        _dispatchGetFavorites();
      } else if (state is FavoriteLoadingFailed) {
        return Text(state.message);
      }
      return Container();
    });
  }

  void _dispatchGetFavorites() {
    _favoritesBloc.dispatch(GetFavoritesEvent());
  }
}
