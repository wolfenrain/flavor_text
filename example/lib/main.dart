import 'package:dashbook/dashbook.dart';
import 'package:flavor_text/flavor_text.dart' hide Property;
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

final theme = {
  'root': TextStyle(
    color: Color(0xff383a42),
    backgroundColor: Color(0x00000000),
  ),
  // 'name': TextStyle(color: Color(0xffe45649)),
  'string': TextStyle(color: Color(0xff50a14f)),
  'attr': TextStyle(color: Color(0xff986801)),
  'tag': TextStyle(color: Color(0xffe45649)),
};

void main() {
  final dashbook = Dashbook();
  final tagsStory = dashbook.storiesOf('Tags');

  tagsStory.add('style', (context) {
    final fontWeight = context.listProperty('fontWeight', 'normal', [
      'w100',
      'w200',
      'w300',
      'w400',
      'w500',
      'w600',
      'w700',
      'w800',
      'w900',
      'normal',
      'bold',
    ]);
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
      'home', 'work', 'motorcycle',
    ]);
    final fontWeight = context.listProperty('fontWeight', 'normal', [
      'w100',
      'w200',
      'w300',
      'w400',
      'w500',
      'w600',
      'w700',
      'w800',
      'w900',
      'normal',
      'bold',
    ]);
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
  }).add('rainbow', (context) => build('<rainbow>Hello world</rainbow>'));

  runApp(dashbook);
}

Widget build(String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      HighlightView(text, language: 'xml', theme: theme),
      SizedBox(height: 16),
      FlavorText(text),
    ],
  );
}
