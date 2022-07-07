import 'package:flutter/material.dart';
import 'package:studentprojectmanager/views/search/widgets/web/search_button.dart';

class SearchButtons extends StatelessWidget {
  const SearchButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            SearchButton(title: 'Search'),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
