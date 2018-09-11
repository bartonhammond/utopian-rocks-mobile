import 'package:flutter/material.dart';
import 'package:utopian_rocks/list_page.dart';
import 'package:utopian_rocks/repository.dart';

import 'package:utopian_rocks/provider.dart';
import 'package:utopian_rocks/bloc.dart';

void main() => runApp(MyApp());

// Root of the widget tree.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // root widget is the [ContributionProvider] so that the BLoC is available anywhere.
    return ContributionProvider(
      // Instantiate the API and the BLoC for the entire application.
      contributionBloc: ContributionBloc(Api()),
      child: MaterialApp(
        // Remove Debug flag to allow app to be production ready.
        debugShowCheckedModeBanner: false,
        title: 'Utopian Rocks Mobile',
        // Setup theme data for Utopian Lato font and Color
        theme: ThemeData(
          fontFamily: 'Lato-Regular',
          primaryColor: Color(0xff24292e),
          accentColor: Color(0xff26A69A),
        ),
        // Setup the tab controller for the two different tabs.
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              // [Flex] allows the image and title to be on the same line in the [AppBar].
              // Use [MainAxisAlignment.spaceEvenly] to add space between the two widgets.
              title: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/utopy.png',
                    ),
                  ),
                  Text(
                    'Utopian Rocks Mobile',
                  ),
                ],
              ),
              // Add [TabBar] to the [AppBar] to allow the user to navigate from one page to the next.
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                      icon: Icon(Icons.rate_review),
                      text: 'Waiting for Review'),
                  Tab(
                      icon: Icon(Icons.hourglass_empty),
                      text: 'Waiting on Upvote'),
                ],
              ),
            ),
            // Body of the application which points towards the two pages.
            // Page one lists the unreviewed contributions and Page two lists the pending contributions.
            body: TabBarView(
              children: <Widget>[
                ListPage('unreviewed'),
                ListPage('pending'),
              ],
            ),
            // Todo: Add information Drawer.
            // endDrawer: Drawer(
            //   semanticLabel: 'Information',
            // ),
          ),
        ),
      ),
    );
  }
}