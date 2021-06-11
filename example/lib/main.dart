import 'package:flavor_text/flavor_text.dart';
import 'package:flutter/material.dart';

/// Tag that adds an [Icons.help] icon in text.
class HelpTag extends Tag {
  @override
  List<String> get supportedProperties => [];

  @override
  InlineSpan build(BuildContext context) {
    return WidgetSpan(child: Icon(Icons.help));
  }
}

void main() {
  FlavorText.registerDefaultTags();
  FlavorText.registerTag('help', () => HelpTag());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavor Text Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flavor Text Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlavorText('Hello <style color="0xFFFF0000">world</style>!'),
            FlavorText('Hello <help/> world!'),
            FlavorText('Welcome <icon>home</icon>'),
          ],
        ),
      ),
    );
  }
}
