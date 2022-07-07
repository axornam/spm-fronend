import 'package:flutter/material.dart';
import 'package:studentprojectmanager/util/router.dart';
import 'package:studentprojectmanager/views/search/search_screen.dart';

// button to show search and im feeling lucky button
class SearchButton extends StatelessWidget {
  final String title;

  const SearchButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: 100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 18,
      ),
      color: Colors.blueAccent,
      onPressed: () {
        MyRouter.pushPage(context, SearchScreen(searchQuery: ''));
      },
      child: Text(
        title,
      ),
    );
  }
}
