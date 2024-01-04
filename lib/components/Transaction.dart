import 'package:flutter/material.dart';
import 'package:google_map_flutter_works/chain-work/block.dart';

import 'package:google_map_flutter_works/flow/flutter_flow_animations.dart';
import 'package:google_map_flutter_works/flow/flutter_flow_theme.dart';
import 'package:google_map_flutter_works/flow/flutter_flow_util.dart';
import 'package:google_map_flutter_works/flow/flutter_flow_widgets.dart';

class TransactionPanel extends StatefulWidget {
  final List<Block> transactions;

  TransactionPanel(this.transactions);

  @override
  _TransactionPanelState createState() => _TransactionPanelState();
}

class _TransactionPanelState extends State<TransactionPanel> {
  late ScrollController _scrollController;
  bool _showScrollIcon = false;
  int _visibleItemCount = 5;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _showScrollIcon = true;
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _visibleItemCount += 5;
        if (_visibleItemCount >= widget.transactions.length) {
          _visibleItemCount = widget.transactions.length;
          _showScrollIcon = false;
        }
      });
    } else {
      setState(() {
        _showScrollIcon = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                Colors.white.withOpacity(0.2), // Adjust the opacity as needed
            width: 1.0, // Adjust the border width as needed
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Transactions',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).titleMedium
              // .override(fontWeight: FontWeight.bold),
              ),
          Divider(
            color: Colors.white.withOpacity(0.2),
          ),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _visibleItemCount + (_showScrollIcon ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _visibleItemCount) {
                  return TransactionItem(widget.transactions[index]);
                } else {
                  //return ScrollIcon(scrollController: _scrollController);
                  return Container();
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white.withOpacity(0.2),
                );
              },
            ),
          ),
          Visibility(
            visible: _showScrollIcon,
            child: Align(
              alignment: Alignment.topRight,
              child: ScrollIcon(scrollController: _scrollController),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final Block transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    IconData iconData = transaction.isSend ? Icons.send : Icons.arrow_downward;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            /*
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(
                      255, 67, 72, 76), // Choose your border color
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  iconData,
                  size: 20.0,
                  color:
                      Color.fromARGB(255, 67, 72, 76), // Choose your icon color
                ),
              ),
            ),*/
            SizedBox(width: 5.0),
            Container(
                child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width -
                      170.0, // Adjust the width as needed
                  child: Text(transaction.timestamp,
                      textAlign: TextAlign.left,
                      style: FlutterFlowTheme.of(context).bodySmall
                      // .override(
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.bold,
                      //    ),
                      ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width -
                      170.0, // Adjust the width as needed
                  child: Text(transaction.data,
                      textAlign: TextAlign.left,
                      style: FlutterFlowTheme.of(context).bodySmall
                      //  .override(fontSize: 16.0),
                      ),
                ),
              ],
            )),
            SizedBox(width: 5.0),
            Text(
              '${transaction.isSend ? '-' : '+'}${transaction.amount}',
              style: TextStyle(
                fontSize: 20.0,
                color: transaction.isSend ? Colors.red : Colors.green,
              ),
            ),
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
  }
}

class ScrollIcon extends StatelessWidget {
  final ScrollController scrollController;

  ScrollIcon({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add logic to scroll down
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      },
      icon: Icon(Icons.arrow_downward, size: 18.0),
    );
  }
}
