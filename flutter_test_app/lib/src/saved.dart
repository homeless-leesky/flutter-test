import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:toast/toast.dart';
class SavedList extends StatefulWidget {
  final Set<WordPair> saved;

  SavedList(
      //constructor
      {@required this.saved});

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selected item list")),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: widget.saved.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }
          var realIndex = index ~/ 2;
          return _buildRow(widget.saved.toList()[realIndex]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(pair.asPascalCase),
      onTap: () {
        setState(() {
          Toast.show(pair.asPascalCase + "is unselected", context, gravity: Toast.BOTTOM);
          widget.saved.remove(pair);
        });
      },
    );
  }
}
