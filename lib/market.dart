import 'package:flutter/material.dart';
import 'package:chain_wallet/chain-work/coin.dart';
import 'package:chain_wallet/chain-work/api_service.dart';

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late List<Coin> coins = [];

  @override
  void initState() {
    super.initState();
    print('in the initState of market rates');
  }

  Future<List<Coin>> _getData() async {
    try {
      List<Coin> fetchedCoins = await ApiService().getCoinRates() ?? [];
      return fetchedCoins; // Return the fetched data
    } catch (error) {
      // Handle error
      print("Error fetching data: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Rates'),
      ),
      body: FutureBuilder<List<Coin>>(
        future: _getData(), // Pass the future to the FutureBuilder
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<Coin> coins = snapshot.data!; // Extract the data

            return ListView.separated(
              itemBuilder: (ctx, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 25.0),
                        Container(
                          child: Image.network(coins[i].image),
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 40.0),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 170.0,
                                child: Text(
                                  coins[i].name ?? '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 170.0,
                                child: Text(
                                  coins[i].currentPrice.toString() ?? '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                    SizedBox(height: 8.0),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Color.fromARGB(255, 40, 22, 109));
              },
              itemCount: coins.length,
            );
          }
        },
      ),
    );
  }
}
