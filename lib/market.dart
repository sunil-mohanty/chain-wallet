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
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemBuilder: (ctx, i) {
                // return Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     ListTile(
                //       title: Text(coins[i].name ?? ''),
                //     ),
                //     Divider(
                //       height: 0,
                //     )
                //   ],
                // );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.network(coins[i].image),
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 5.0),
                        Container(
                            child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width -
                                  170.0, // Adjust the width as needed
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
                              width: MediaQuery.of(context).size.width -
                                  170.0, // Adjust the width as needed
                              child: Text(
                                coins[i].currentPrice.toString() ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(width: 5.0),
                        // Text(
                        //   '${transaction.isSend ? '-' : '+'}${transaction.amount}',
                        //   style: TextStyle(
                        //     fontSize: 20.0,
                        //     color:
                        //         transaction.isSend ? Colors.red : Colors.green,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    /*
        Text(
          transaction.data,
          style: TextStyle(fontSize: 16.0),
        ),*/
                    //SizedBox(height: 16.0),
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
