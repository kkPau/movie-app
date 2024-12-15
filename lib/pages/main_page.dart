// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/main_page_data.dart';

import '../controllers/main_page_data_controller.dart';

import '../models/movie.dart';
import '../models/search_category.dart';

import '../widgets/movie_tile.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, dynamic>(
  (ref) {
    return MainPageDataController();
  },
);

class MainPage extends ConsumerWidget {
  late double _deviceHeight;
  late double _deviceWidth;

  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  late TextEditingController _searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _mainPageDataController = ref.watch(mainPageDataControllerProvider
        as ProviderListenable<MainPageDataController>);
    _searchTextFieldController = TextEditingController();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
              "https://m.media-amazon.com/images/M/MV5BZmYzMzU4NjctNDI0Mi00MGExLWI3ZDQtYzQzYThmYzc2ZmNjXkEyXkFqcGdeQXVyMTEyMjM2NDc2._V1_.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
            child: _moviesListViewWidget(),
          )
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    const _border = InputBorder.none;
    return Container(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (value) {},
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          focusedBorder: _border,
          border: _border,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
          hintStyle: TextStyle(color: Colors.white54),
          filled: false,
          fillColor: Colors.white24,
          hintText: "Search...",
        ),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
        dropdownColor: Colors.black38,
        value: SearchCategory.popular,
        icon: const Icon(Icons.menu, color: Colors.white24),
        underline: Container(height: 1, color: Colors.white24),
        items: const [
          DropdownMenuItem(
            value: SearchCategory.popular,
            child: Text(
              SearchCategory.popular,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem(
            value: SearchCategory.upcoming,
            child: Text(
              SearchCategory.upcoming,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem(
            value: SearchCategory.none,
            child: Text(
              SearchCategory.none,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        onChanged: (value) {});
  }

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = [];

    for (var i = 0; i < 20; i++) {
      _movies.add(Movie(
          name: "Oppenheimer",
          language: "EN",
          isAdult: false,
          description:
              "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.",
          posterPath: "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
          backdropPath: "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg",
          rating: 7.9,
          releaseDate: "2021-04-07"));
    }
    if (_movies.length != 0) {
      return ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: _deviceHeight * 0.01, horizontal: 0),
            child: GestureDetector(
              onTap: () {},
              child: MovieTile(
                height: _deviceHeight * 0.20,
                width: _deviceWidth * 0.85,
                movie: _movies[index],
              ),
            ),
          );
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
