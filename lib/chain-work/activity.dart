import 'package:flutter/material.dart';
import 'block.dart';
import 'wallet.dart';
import 'api_service.dart';
import 'package:getwidget/getwidget.dart';
import 'package:chain_wallet/components/CircularButton.dart';
import 'package:chain_wallet/finwallet/Transaction.dart';
import 'package:chain_wallet/signin.dart';
import 'package:chain_wallet/market.dart';
import 'package:chain_wallet/finwallet/home-page.dart';
import 'package:chain_wallet/BottomNavigationBarScreen.dart';

class Activity extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  Activity({Key? key, this.arguments}) : super(key: key);
  /*
  Activity.withEmailAndWalletsAndBlocks(
      this.username, this.password, this._wallets, this._blocks,
      {Key? key})
      : super(key: key);*/

  @override
  _ActivityState createState() => _ActivityState(this.arguments);

  /*
  @override
  _ActivityState createState() => _ActivityState.withEmailAndWalletsAndBlocks(
      this.username, this._wallets, this._blocks);
  */
}

class _ActivityState extends State<Activity> {
  late String? username;
  late List<Wallet> _wallets = [];
  late List<Block> _blocks = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Block? selectedBlock = null;
  Wallet? selectedWallet = null;
  final Map<String, dynamic>? arguments;
  //_ActivityState(this.username, {Key? key}) : super();
  _ActivityState(this.arguments, {Key? key}) : super();

/*
  _ActivityState.withEmailAndWalletsAndBlocks(
      this.username, this._wallets, this._blocks,
      {Key? key})
      : super() {
    selectedWallet = _wallets.isNotEmpty ? _wallets.first : null;
    selectedBlock = _blocks.isNotEmpty ? _blocks.first : null;
  }
 */

  // Define the current index for the selected tab in the bottom navigation bar
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //---_getData();
    username = widget.arguments?['username'];
    print('arguments initState(): ${widget.arguments}');
    print('arguments initState(): ${arguments}');

    _getWallet();
    _displayDummyData();
  }

  void _getData() async {
    _blocks = (await ApiService().getBlocks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          // Map the API response to your MyObject class

          // Preselect the first element
          selectedBlock = _blocks.isNotEmpty ? _blocks.first : null;
        }));
  }

  void _getWallet() async {
    print('username in the getWallet of the activity.dart $username');

    _wallets = (await ApiService().listWallets(username))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          // Map the API response to your MyObject class

          // Preselect the first element
          selectedWallet = _wallets.isNotEmpty ? _wallets.first : null;
        }));
  }

  void _displayDummyData() {
    // Dummy transaction data
    List<Block> dummyTransactions = [
      Block(
          timestamp: '2023-11-7 10:00 AM',
          lastHash: '0X1X2X3X',
          hash: '00XZ1WRTS',
          data: 'Sent AED 50 to John',
          noance: 7,
          difficulty: 6,
          isSend: true,
          amount: 50),

      Block(
          timestamp: '2023-11-10 10:00 AM',
          lastHash: '0X2X2X3X',
          hash: '00XZ2WRTS',
          data: 'Received AED 100 from Alice',
          noance: 7,
          difficulty: 6,
          isSend: false,
          amount: 100),
      Block(
          timestamp: '2023-11-11 10:00 AM',
          lastHash: '0X3X2X3X',
          hash: '00XZ3WRTS',
          data: 'Sent AED 30 to Bob',
          noance: 7,
          difficulty: 6,
          isSend: true,
          amount: 30),
      Block(
          timestamp: '2023-11-11 10:00 AM',
          lastHash: '0X3X2X3X',
          hash: '00XZ3WRTS',
          data: 'Received AED 35 from Pechulu chuuaa',
          noance: 7,
          difficulty: 6,
          isSend: false,
          amount: 35),
      Block(
          timestamp: '2023-11-11 10:00 AM',
          lastHash: '0X3X2X3X',
          hash: '00XZ3WRTS',
          data: 'Sent AED 40 to Mingulu',
          noance: 7,
          difficulty: 6,
          isSend: true,
          amount: 40),
      Block(
          timestamp: '2023-11-11 10:00 AM',
          lastHash: '0X3X2X3X',
          hash: '00XZ3WRTS',
          data: 'Sent AED 40 to Bob',
          noance: 7,
          difficulty: 6,
          isSend: true,
          amount: 40),
      Block(
          timestamp: '2023-11-11 10:00 AM',
          lastHash: '0X3X2X3X',
          hash: '00XZ3WRTS',
          data: 'Received AED 30 from Mike',
          noance: 7,
          difficulty: 6,
          isSend: false,
          amount: 30),
      Block(
          timestamp: '2023-11-11 10:00 AM',
          lastHash: '0X3X2X3X',
          hash: '00XZ3WRTS',
          data: 'Sent AED 10 to Mamata Banarjee',
          noance: 7,
          difficulty: 6,
          isSend: true,
          amount: 10),
      // Add more dummy transactions as needed
    ];

    setState(() {
      _blocks = dummyTransactions;
      selectedBlock = _blocks.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Extract arguments
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    print('final Map<String, dynamic>? arguments $arguments');
    // Access the values
    final String? username = arguments?['username'];
    final String? otherValue = arguments?['otherKey'];
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        // ignore: prefer_const_constructors
        width: double.infinity,
        decoration: BoxDecoration(
          // ignore: prefer_const_constructors
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 13, 19, 133),
              Color.fromARGB(255, 87, 91, 35),
            ], // Adjust colors as needed
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0), // Add space here

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height: 10.0), // Adjust the space as needed
            Center(
              child: Container(
                width: 385.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: Center(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: DropdownButtonHideUnderline(
                      child: GFDropdown(
                        value: selectedWallet,
                        onChanged: (newValue) {
                          setState(() {
                            selectedWallet = newValue as Wallet;
                          });
                        },
                        items: _wallets.map<DropdownMenuItem<Wallet>>((value) {
                          return DropdownMenuItem<Wallet>(
                            value: value,
                            child: CustomDropdownItem(value),
                          );
                        }).toList(),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                        iconSize: 24.0,
                        isExpanded: true,
                        isDense: true,
                        elevation: 16,
                        selectedItemBuilder: (BuildContext context) {
                          return _wallets.map<Widget>((Wallet item) {
                            return Container(
                              width: 310.0,
                              alignment: Alignment.center,
                              child: Text(
                                  'WALLET - ' +
                                      item.walletId
                                          .toUpperCase()
                                          .substring(0, 10),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            );
                          }).toList();
                        },
                        itemHeight: 50.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                'AED ${selectedWallet?.balance ?? 'N/A'}',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(179, 249, 246, 246)),
              ),
            ),

            SizedBox(height: 20.0), // Add space before the transaction list
            Flexible(
              child: TransactionPanel(_blocks),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic here
                // For example, navigate to the login screen
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => const MapApp())
                    context,
                    MaterialPageRoute(builder: (context) => Signin()));
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

class CustomDropdownItem extends StatelessWidget {
  final Wallet wallet;

  CustomDropdownItem(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.grey[200],
      child: Text(' WALLET -' + wallet.walletId.substring(0, 6)),
    );
  }
}

class CardContentWidget extends StatelessWidget {
  List<Block> _blocks;
  int index;

  CardContentWidget(this._blocks, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _blocks[index].timestamp,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              _blocks[index].data,
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
