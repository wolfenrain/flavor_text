import 'package:flavor_text/flavor_text.dart';
import 'package:flutter/material.dart';

/// Tag that adds an [Icons.help] icon in text.
class HelpTag extends Tag {
  @override
  List<Property> get supportedProperties => [Property('color')];

  @override
  InlineSpan build(BuildContext context) {
    final colorValue = properties['color']?.value;
    var color = Colors.black;
    if (colorValue != null) {
      color = Color(int.parse(colorValue));
    }

    return WidgetSpan(
      child: Icon(
        Icons.help,
        color: color,
      ),
    );
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
      appBar:
          AppBar(title: FlavorText('<rainbow>Flavor Text Example</rainbow>')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlavorText(
                '<style color="primaryColor">Hello</style> <style color="0xFFFF0000">world</style>!'),
            FlavorText(
                'Hello <help color="0xFF00FF00"/> <rainbow>world</rainbow>!'),
            FlavorText('Welcome <icon color="primaryColor">home</icon>'),
          ],
        ),
      ),
    );
  }
}
