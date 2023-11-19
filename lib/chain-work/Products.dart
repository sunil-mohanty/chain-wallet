import 'package:flutter/material.dart';
import 'block.dart';
import 'wallet.dart';
import 'api_service.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_map_flutter_works/components/CircularButton.dart';
import 'package:google_map_flutter_works/signin.dart';

class Home extends StatefulWidget {
  final String? email;
  final String? password;

  Home(this.email, this.password, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(this.email);
}

class _HomeState extends State<Home> {
  final String? email;

  _HomeState(this.email, {Key? key}) : super();

  late List<Wallet> _wallets = [];
  late List<Block> _blocks = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Block? selectedBlock = null;
  Wallet? selectedWallet = null;

  @override
  void initState() {
    super.initState();
    //_getData();
    _getWallet();
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
    _wallets = (await ApiService().listWallets(email))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          // Map the API response to your MyObject class

          // Preselect the first element
          selectedWallet = _wallets.isNotEmpty ? _wallets.first : null;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      /*appBar: AppBar(
        title: const Text('Transations'),
      ),*/
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
              //Color(0xFF17ead9),
              //Color(0xFF6078ea)
              // Color.fromARGB(255, 54, 117, 179),
              // Color.fromARGB(255, 2, 15, 28)
            ], // Adjust colors as needed
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            SizedBox(height: 20.0), // Adjust the space as needed
            Center(
              child: Container(
                width: 315.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                        icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                        iconSize: 24.0,
                        isExpanded: true,
                        isDense: true,
                        elevation: 16,
                        selectedItemBuilder: (BuildContext context) {
                          return _wallets.map<Widget>((Wallet item) {
                            return Container(
                              width: 310.0,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'wallet - ' + item.walletId.substring(0, 6)),
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
            SizedBox(height: 50.0),
            Center(
              child: Text(
                'AED ${selectedWallet?.balance ?? 'N/A'}',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(179, 249, 246, 246)),
              ),
            ),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularIconButton(
                    icon: Icons.send,
                    label: 'Send',
                    onPressed: () => print('Send pressed')),
                CircularIconButton(
                    icon: Icons.arrow_downward,
                    label: 'Reveive',
                    onPressed: () => print('Receive pressed')),
                CircularIconButton(
                    icon: Icons.shopping_cart,
                    label: 'Buy',
                    onPressed: () => print('Buy pressed')),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Drawer content goes here
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: DrawerContent(),
        ),
      ),
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
      child: Text(' wallet - ' + wallet.walletId.substring(0, 6)),
    );
  }
}

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            // Handle drawer item tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            // Handle drawer item tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        Divider(), // Add a divider for separation
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            // Implement logout functionality
            // For example, you can show a confirmation dialog and log the user out
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your logout logic here
                        // For example, navigate to the login screen
                        /*
                        Navigator.pop(context); // Close the dialog
                        Navigator.pushReplacementNamed(context, '/login');
                        */

                        Navigator.push(
                            //context, MaterialPageRoute(builder: (context) => const MapApp())
                            context,
                            MaterialPageRoute(builder: (context) => MyApp1()));
                      },
                      child: Text('Logout'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
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
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _blocks[index].timestamp,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              _blocks[index].data,
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
