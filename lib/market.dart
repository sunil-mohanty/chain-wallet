import 'package:flutter/material.dart';
import 'package:google_map_flutter_works/chain-work/coin.dart';
import 'package:google_map_flutter_works/chain-work/api_service.dart';

class MarketScreen extends StatefulWidget {
  @override
  _AddAssetScreenState createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<MarketScreen> {
  late List<Coin> coins = [];

  @override
  void initState() {
    super.initState();
    print('in the initState of market rates');
    _getData();
  }

  Future<void> _getData() async {
    try {
      List<Coin> fetchedCoins = await ApiService().getCoinRates() ?? [];
      setState(() {
        coins = fetchedCoins;
      });
    } catch (error) {
      // Handle error
      print("Error fetching data: $error");
    }
    print(coins);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Rates'),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemBuilder: (ctx, i) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(coins[i].name ?? ''),
                    ),
                    Divider(
                      height: 0,
                    )
                  ],
                );
              },
              itemCount: coins.length,
            );
          }
        },
      ),
    );
  }
}
