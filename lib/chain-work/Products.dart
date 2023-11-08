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
      appBar: AppBar(
        title: const Text('Transations'),
      ),
      body: ListView.builder(
        itemCount: _blocks.length,
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }
}
