import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
    final randomWords = <WordPair>[];
    final savedWords = Set<WordPair>();

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, item){
        if (item.isOdd) return Divider();

        final index = item ~/ 2;

        if (index >= randomWords.length) {
          randomWords.addAll(generateWordPairs().take(10));
        }
        return _buildRow(randomWords[index]);
      },
    );
  }

  Widget _buildRow (WordPair pair) {
    final alreadySaved = savedWords.contains(pair);

    return ListTile(
      title: Text (
        pair.asPascalCase,
        style: TextStyle (fontSize: 18.0),
      ),
      trailing: Icon (
          alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            savedWords.remove(pair);
          } else {
            savedWords.add(pair);
          }
        });
      },
    );
  }

  void _saved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context)
    {
      final Iterable <ListTile> tiles = savedWords.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase,
                style: TextStyle(fontSize: 16.0)));
      });
      final List<Widget> divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
            title: Text("Saved Words")),
        body: ListView(children: divided),
      );
    }));
  }

  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            leading: Icon((Icons.wysiwyg),
                ),
            title: Text("Word Generator"),
            actions: [
              IconButton(
            icon: Icon(Icons.list),
            onPressed: _saved)
          ],
        ),
        body: _buildList(),
      );
    }
}