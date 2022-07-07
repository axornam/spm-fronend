import 'package:flutter/material.dart';
import 'package:studentprojectmanager/views/search/widgets/web/search_button.dart';
import 'package:studentprojectmanager/views/search/widgets/web/web_search.dart';
import 'package:studentprojectmanager/views/search/widgets/web/search_buttons.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Search',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.25),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // since children of column are not supposed to be 'spaced between'
                      Column(
                        children: const [
                          Search(),
                          SizedBox(height: 20),
                          SearchButtons()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
