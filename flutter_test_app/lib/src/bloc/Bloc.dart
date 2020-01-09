import 'dart:async';
import 'package:english_words/english_words.dart';

class Bloc {
  Set<WordPair> saved = Set<WordPair>(); //make set

  final _savedController =
      StreamController<Set<WordPair>>.broadcast(); //make stream controller

  get savedStream => _savedController.stream;

  get addCureentSaved => _savedController.sink.add(saved);

  addToOrRemoveFromSavedList(WordPair item) {
    if (saved.contains(item)) {
      saved.remove(item);
    } else {
      saved.add(item);
    }
    _savedController.sink.add(saved);
  }

  dispose() {
    //stream close
    _savedController.close();
  }
}

var bloc = Bloc(); // block instance create
// -> small app
