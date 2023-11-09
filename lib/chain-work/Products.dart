import 'package:flutter/material.dart';
import 'block.dart';
import 'api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Block> _blocks = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _blocks = (await ApiService().getBlocks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      /*appBar: AppBar(
        title: const Text('Transations'),
      ),*/
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _blocks.length,
            itemBuilder: (context, index) {
              return CardContentWidget(_blocks, index);
            },
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Open the drawer using the GlobalKey
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // Drawer content goes here
        child: DrawerContent(),
      ),
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
            Text(_blocks[index].data),
          ],
        ),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Drawer content goes here
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
      ],
    );
  }
}
