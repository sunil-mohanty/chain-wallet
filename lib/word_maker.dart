import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

class word_maker extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }
   @override
  class _MyHomePageState extends State<word_maker> {
  String _textString = 'Hello world';

    Widget build(BuildContext context) {
    return new Scaffold(

        body:   GridView(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                     ),
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  _textString,
                  style: TextStyle(fontSize: 30),
                ),
                TextField( //  <--- TextField
                  onChanged: (text) {
                  _doSomething(text);
                },
                ),

            ],
          ),
          ),
          Container(
          		  child: Column(
          		    children: [
          		      Text(
          		        _textString,
          		        style: TextStyle(fontSize: 30),
          		      ),
          		      TextField( //  <--- TextField
          		        onChanged: (text) {
          		        _doSomething(text);
          		      },
          		      ),
          		  ],
          		),
          	),
        ],
      ),
    )
     ;
   }
   void _doSomething(String text) {
      setState(() {
          _textString = text;
      });
   }
}








































