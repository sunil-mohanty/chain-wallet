import 'package:flutter/material.dart';
import 'block.dart';
import 'api_service.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Block> _blocks = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Block? selectedObject = null;

  @override
  void initState() {
    super.initState();
    _getData();
    print(_blocks);
  }

  void _getData() async {
    _blocks = (await ApiService().getBlocks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          // Map the API response to your MyObject class

          // Preselect the first element
          selectedObject = _blocks.isNotEmpty ? _blocks.first : null;
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
              Color.fromARGB(255, 54, 117, 179),
              Color.fromARGB(255, 2, 15, 28)
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
                        value: selectedObject,
                        onChanged: (newValue) {
                          setState(() {
                            selectedObject = newValue as Block;
                          });
                        },
                        items: _blocks.map<DropdownMenuItem<Block>>((value) {
                          return DropdownMenuItem<Block>(
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
                          return _blocks.map<Widget>((Block item) {
                            return Container(
                              width: 310.0,
                              alignment: Alignment.centerLeft,
                              child: Text(' wallet - ' + item.hash),
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
          ],
        ),
      ),

      /*
        child: Stack(
          children: [
            Positioned(
              top: 16.0,
              left: 16.0,
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.pink[100]),
                onPressed: () {
                  // Open the drawer using the GlobalKey
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            Positioned(
              top: 120.0,
              left: 25.0,
              child: Container(
                width: 315.0, // Set width
                height: 60.0, // Set height
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),

                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      padding: const EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(8),
                      border: const BorderSide(color: Colors.black12, width: 1),
                      dropdownButtonColor: Color.fromARGB(255, 236, 240, 242),
                      value: selectedObject,
                      onChanged: (newValue) {
                        setState(() {
                          selectedObject = newValue as Block;
                        });
                      },
                      items: _blocks
                          .asMap()
                          .entries
                          .map<DropdownMenuItem<Block>>((entry) {
                        // Using asMap to get index for assigning colors
                        int index = entry.key;
                        Block value = entry.value;
                        Color itemColor = index % 2 == 0
                            ? Colors.grey[200]!
                            : Colors.white; // Example: Alternate colors

                        return DropdownMenuItem<Block>(
                          value: value,
                          child: CustomDropdownItem(value, itemColor),
                        );
                      }).toList(),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.blue), // Set custom dropdown icon
                      iconSize: 24.0, // Set icon size
                      isExpanded: true,
                      isDense: true,
                      // Allow the dropdown to expand to the width of its parent

                      elevation: 16,
                      /*
                      underline: Container(
                        height: 0,
                      ),*/
                      selectedItemBuilder: (BuildContext context) {
                        return _blocks.map<Widget>((Block item) {
                          return Container(
                            width: 310.0,
                            alignment: Alignment.centerLeft,
                            child: Text(' wallet - ' + item.hash),
                          );
                        }).toList();
                      },
                      itemHeight: 60.0, // Set the height of each item
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),*/
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
/*
class CustomDropdownItem extends StatelessWidget {
  final Block block;
  final Color color;

  CustomDropdownItem(this.block, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
            color: Colors
                .black), // Add a Divider before each item (customize color as needed)
        Container(
          width: 250.0, // Set the width of each item in the dropdown menu
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: color, // Set the background color for the item
          child: Text(' wallet - ' + block.hash.substring(0, 6)),
        ),
      ],
    );
  }
}
*/

class CustomDropdownItem extends StatelessWidget {
  final Block block;

  CustomDropdownItem(this.block);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.grey[200],
      child: Text(' wallet - ' + block.hash.substring(0, 6)),
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
