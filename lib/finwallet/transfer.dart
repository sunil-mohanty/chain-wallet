import 'package:flutter/material.dart';
import '../chain-work/api_service.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_map_flutter_works/components/CircularButton.dart';
import 'package:google_map_flutter_works/finwallet/Transaction.dart';
import 'package:google_map_flutter_works/signin.dart';
import 'package:google_map_flutter_works/market.dart';
import 'package:google_map_flutter_works/finwallet/home-page.dart';
import 'package:google_map_flutter_works/BottomNavigationBarScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_map_flutter_works/components/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import '../chain-work/api_service.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_map_flutter_works/components/CircularButton.dart';
import 'package:google_map_flutter_works/finwallet/Transaction.dart';
import 'package:google_map_flutter_works/signin.dart';
import 'package:google_map_flutter_works/market.dart';
import 'package:google_map_flutter_works/finwallet/home-page.dart';
import 'package:google_map_flutter_works/BottomNavigationBarScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_map_flutter_works/components/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Transfer extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  Transfer({Key? key, this.arguments}) : super(key: key);

  @override
  _TransferState createState() => _TransferState(this.arguments);
}

class _TransferState extends State<Transfer> {
  final Map<String, dynamic>? arguments;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _TransferState(this.arguments, {Key? key}) : super();
  String selectedCurrency = 'Magnet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 13, 19, 133),
              Color.fromARGB(255, 87, 91, 35),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Choose Currency',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Lexend Deca',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Container(
                height: 80.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CurrencyBox('Magnet', 'MGT M'),
                    CurrencyBox('Tether', 'USDT	₮'),
                    CurrencyBox('Ripple', 'XRP	X'),
                    // Add more currencies as needed
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            if (selectedCurrency.isNotEmpty)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  height: 120.0,
                  child: AccountInfoField(selectedCurrency),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget CurrencyBox(String currency, String symbol) {
    int numberOfBoxes = 3; // Set the total number of boxes
    double boxWidth = MediaQuery.of(context).size.width / numberOfBoxes - 32;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCurrency = currency;
        });
      },
      child: Container(
        width: boxWidth,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedCurrency == currency
              ? Color.fromARGB(255, 72, 83, 92)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              symbol,
              style: TextStyle(
                fontSize: 24.0,
                color:
                    selectedCurrency == currency ? Colors.white : Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              currency,
              style: TextStyle(
                color:
                    selectedCurrency == currency ? Colors.white : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget AccountInfoField(String currency) {
  // Replace the following with your actual balance and currency name logic
  String balance = '5000';
  String currencyName = currency;

  return Column(
    children: [
      SizedBox(height: 16.0),
      Text(
        'Your Account',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      SizedBox(height: 20.0),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 72, 83, 92),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currencyName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Text(
              'Balance: $balance ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
