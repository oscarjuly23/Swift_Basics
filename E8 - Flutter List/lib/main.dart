import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
    MyApp(
       items: List<ListItem>.generate(
        12,
            (i) => i % 6 == 0 ? HeadingItem('Bienvenidos a Keoland $i') : MessageItem('Bando Boyz Free $i', 'Brr'),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  const MyApp({Key key,  this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'KEO List';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appBar: AppBar(
          //title: const Text(title),
        //),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              // Provide a standard title.
              title: Text(title),
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items.
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.
              //flexibleSpace: Placeholder(),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 100,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text('Bienvenidos a Keoland',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      wordSpacing: 5
                    ),
                    textAlign: TextAlign.center
                ),
              )
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      color: Colors.primaries[index % Colors.primaries.length],
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        "Bando Boyz Free $index",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                },
                childCount: 70, //list items
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => Text('');
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender, style: TextStyle(
      color: Colors.grey
  ));

  @override
  Widget buildSubtitle(BuildContext context) => Text(body, style: TextStyle(color: Colors.blueAccent));
}