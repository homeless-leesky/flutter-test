import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:toast/toast.dart';
import 'saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); //there is no same object

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("test app"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SavedList(saved: _saved))); // -> send _saved reference
              },
            ),
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) {
        return Divider();
      }
      var realIndex = index ~/ 2; //2를 나눈 몫

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[realIndex]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair); // 이미 저장되어 있으면(포함) true
    return ListTile(
      title: Text(
        pair.asPascalCase,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        setState(() {
          // -> 안에 있는 거 실행한 후에 statefulwidget 안에 있는 state 재실행
          if (alreadySaved) {
            Toast.show(pair.asPascalCase + "is unselected!", context, gravity: Toast.BOTTOM);
            _saved.remove(pair);
          } else {
            Toast.show(pair.asPascalCase + "is selected!", context, gravity: Toast.BOTTOM);
            _saved.add(pair);
          }
        });
        print(_saved.toString());
      },
    );
  }
}
