import 'package:flutter/material.dart';

import 'package:google_map_flutter_works/finwallet/home-page.dart';
import 'signin.dart';
import 'package:google_map_flutter_works/chain-work/activity.dart';
import 'package:google_map_flutter_works/finwallet/transfer.dart';
import 'market.dart';

class MainScreen extends StatefulWidget {
  final Map<String, dynamic>? initialArguments;

  MainScreen({this.initialArguments});

  @override
  _MainScreenState createState() => _MainScreenState(this.initialArguments);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  final Map<String, dynamic>? initialArguments;

  _MainScreenState(this.initialArguments, {Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
          ],
          onTap: (index) {
            setState(() {
              if (index == 2) {
                // Logout icon tapped
                _handleLogout();
              } else {
                if (index == 0) {
                  // Home icon tapped
                  _navigatorKeys[0]
                      .currentState
                      ?.popUntil((route) => route.isFirst);
                }
                _selectedIndex = index;
              }
            });
          },
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0, initialArguments),
            _buildOffstageNavigator(1, initialArguments),
            _buildOffstageNavigator(2, initialArguments),
          ],
        ),
      ),
      //),
    );
  }

  void _handleLogout() {
    // Perform logout logic here...

    // Navigate to the Sign In screen and remove all existing routes
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false, // This line removes all existing routes
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    print('index in side the _routeBuilders : $index');
    return {
      '/': (context) {
        return [
          HomePageWidget(),
          MarketScreen(),
          Signin(),
        ].elementAt(index);
      },
      '/home': (context) => HomePageWidget(),
      '/activity': (context) => Activity(),
      '/transfer': (context) => Transfer(),
    };
  }

  Widget _buildOffstageNavigator(
      int index, Map<String, dynamic>? initialArguments) {
    var routeBuilders = _routeBuilders(context, index);
    print('index $index');
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
          key: _navigatorKeys[index],
          onGenerateRoute: (settings) {
            print('settings.name ----->');
            print(settings.name);

            var builder = routeBuilders[settings.name];

            if (builder != null) {
              return MaterialPageRoute(
                builder: (context) => builder(context),
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            }
            // }
          }),
    );
  }
}
