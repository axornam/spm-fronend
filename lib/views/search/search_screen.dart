import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studentprojectmanager/components/book_list_item.dart';
import 'package:studentprojectmanager/views/search/widgets/web/web_search_header.dart';

import '../../util/api.dart';
// import 'package:studentprojectmanager/views/search/widgets/search_tabs.dart';

class SearchScreen extends StatelessWidget {
  final String searchQuery;
  final String start;
  const SearchScreen({Key? key, required this.searchQuery, this.start = '0'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Title(
        // for the title of the website
        color: Colors.blue, // This is required
        title: searchQuery,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Search Results For: " + searchQuery),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // for the header part of the website showing search text field
                const WebSearchHeader(),
                // for showing ALL, IMAGES, MAPS etc tabs
                Padding(
                  padding:
                      EdgeInsets.only(left: size.width <= 768 ? 10 : 150.0),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // child: SearchTabs(),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 0,
                ),
                // showing search results

                FutureBuilder<Map<String, dynamic>>(
                  future: Api().doSearch(searchQuery),
                  builder: (context, snapshot) {
                    Logger l = Logger();

                    if (snapshot.connectionState == ConnectionState.done) {
                      l.d(snapshot.data?['body'].length);

                      if (snapshot.hasData) {
                        //
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?['body'].length,
                              itemBuilder: (context, index) {
                                var entry =
                                    snapshot.data?['body'][index.toString()];

                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width <= 768 ? 10 : 150,
                                      top: 10),
                                  child: BookListItem(
                                    entry: entry,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
