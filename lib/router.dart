import 'package:flutter/material.dart';

import 'package:google_map_flutter_works/finwallet/home-page.dart';

import 'signin.dart';
import 'package:google_map_flutter_works/chain-work/activity.dart';

class RouterPage extends StatelessWidget {
  final String initialRoute;
  final Map<String, dynamic>? initialArguments; // Accept initial arguments

  RouterPage({required this.initialRoute, this.initialArguments});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        // Use different builders for each route
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => Signin(),
              settings: RouteSettings(name: '/', arguments: initialArguments),
            );
          case '/activity':
            return MaterialPageRoute(
              builder: (context) => Activity(),
              settings:
                  RouteSettings(name: '/activty', arguments: initialArguments),
            );

          default:
            // Handle unknown routes or return a default route
            return MaterialPageRoute(
              builder: (context) => Signin(),
              settings: RouteSettings(name: '/', arguments: initialArguments),
            );
        }
      },
    );
  }
}
