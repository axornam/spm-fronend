import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:studentprojectmanager/components/body_builder.dart';
import 'package:studentprojectmanager/components/book_card.dart';
import 'package:studentprojectmanager/components/book_list_item.dart';
import 'package:studentprojectmanager/models/category.dart';
import 'package:studentprojectmanager/util/router.dart';
import 'package:studentprojectmanager/view_models/home_provider.dart';
import 'package:studentprojectmanager/views/genre/genre.dart';
import '../../util/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getFeeds(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(
      builder:
          (BuildContext context, HomeProvider homeProvider, Widget? child) {
        return Scaffold(
          body: _buildBody(homeProvider),
        );
      },
    );
  }

  Widget _buildBody(HomeProvider homeProvider) {
    return BodyBuilder(
      apiRequestStatus: homeProvider.apiRequestStatus,
      child: _buildBodyList(homeProvider),
      reload: () => homeProvider.getFeeds(),
    );
  }

  Widget _buildBodyList(HomeProvider homeProvider) {
    return RefreshIndicator(
      onRefresh: () => homeProvider.getFeeds(),
      child: ListView(
        children: <Widget>[
          // _buildFeaturedSection(homeProvider),
          SizedBox(height: 20.0),
          _buildSectionTitle('Categories'),
          SizedBox(height: 10.0),
          _buildGenreSection(homeProvider),
          SizedBox(height: 20.0),
          _buildSectionTitle('Projects'),
          SizedBox(height: 20.0),
          _buildProjectsSection(homeProvider),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _buildFeaturedSection(HomeProvider homeProvider) {
    return Container(
      height: 200.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: homeProvider.projects.feed?.entry?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Entry entry = homeProvider.projects.feed!.entry![index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: BookCard(
                img: entry.link![1].href!,
                entry: entry,
              ),
            );
          },
        ),
      ),
    );
  }

  _buildGenreSection(HomeProvider homeProvider) {
    return Container(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: homeProvider.categories['body']?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var link = homeProvider.categories['body'][index];
            // Logger logger = Logger();
            // logger.d(homeProvider.projects['body']);
            // logger.d(link['name']);

            // We don't need the tags from 0-9 because
            // they are not categories

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  onTap: () {
                    MyRouter.pushPage(
                      context,
                      Genre(
                        title: '${link['name']}',
                        url: '${link['id']!}',
                      ),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '${link['name']}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildProjectsSection(HomeProvider homeProvider) {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeProvider.projects['body']?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        var entry = homeProvider.projects['body']?[index];
        Logger l = Logger();
        l.d(entry);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: BookListItem(
            entry: entry,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
