import 'package:dashbook/dashbook.dart';
import 'package:flavor_text/flavor_text.dart' hide Property;
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

final lightTheme = {
  'root': TextStyle(color: Colors.black, backgroundColor: Color(0x00000000)),
  'string': TextStyle(color: Color(0xff50a14f)),
  'attr': TextStyle(color: Color(0xff986801)),
  'tag': TextStyle(color: Color(0xffe45649)),
};
final darkTheme = {
  ...lightTheme,
  'root': lightTheme['root']!.copyWith(color: Colors.white),
};

void main() {
  final dashbook = Dashbook.dualTheme(
    title: 'flavor_text examples',
    light: ThemeData.light(),
    dark: ThemeData.dark(),
    initWithLight: false,
  );
  final tagsStory = dashbook.storiesOf('Tags');

  tagsStory.add('style', (context) {
    final fontWeight = context.listProperty(
      'fontWeight',
      'normal',
      StyleTag.fontWeights.keys.toList(),
    );
    final fontSize = context.numberProperty('fontSize', 24);
    final letterSpacing = context.numberProperty('letterSpacing', 2);
    final color = context.colorProperty('color', Colors.blue);

    return build('''<style 
  color="0x${color.value.toRadixString(16)}"
  fontSize="$fontSize" 
  letterSpacing="$letterSpacing" 
  fontWeight="$fontWeight">
  Hello world
</style>''');
  }).add('icon', (context) {
    final icon = context.listProperty('icon', 'home', [
      'home',
      'work',
      'motorcycle',
    ]);
    final fontWeight = context.listProperty(
      'fontWeight',
      'normal',
      StyleTag.fontWeights.keys.toList(),
    );
    final fontSize = context.numberProperty('fontSize', 24);
    final letterSpacing = context.numberProperty('letterSpacing', 2);
    final color = context.colorProperty('color', Colors.blue);

    return build('''<icon
  color="0x${color.value.toRadixString(16)}"
  fontSize="$fontSize" 
  letterSpacing="$letterSpacing" 
  fontWeight="$fontWeight">
  $icon
</icon>''');
  }).add('rainbow', (context) {
    return build('<rainbow>Hello world</rainbow>');
  });

  runApp(dashbook);
}

Widget build(String text) {
  return Builder(
    builder: (context) {
      final isLight = Theme.of(context).brightness == Brightness.light;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HighlightView(
            text,
            language: 'xml',
            theme: isLight ? lightTheme : darkTheme,
          ),
          SizedBox(height: 16),
          FlavorText(text),
        ],
      );
    },
  );
}
