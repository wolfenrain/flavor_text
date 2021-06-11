/// A lightweight and fully customisable text parser for Flutter.
library flavor_text;

import 'dart:collection';

import 'package:dartlin/dartlin.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

part 'src/tags/icon_tag.dart';
part 'src/tags/rainbow_tag.dart';
part 'src/tags/style_tag.dart';
part 'src/tags/text_tag.dart';
part 'src/property.dart';
part 'src/tag.dart';

typedef TagBuilder<T extends Tag> = T Function();

/// Builds rich texts from a [text] using [Tag]s.
class FlavorText extends StatelessWidget {
  final String text;

  final TextStyle? style;

  final TextAlign? textAlign;

  FlavorText(
    this.text, {
    this.style,
    this.textAlign,
  });

  InlineSpan _build(XmlNode node, BuildContext context, [InlineSpan? parent]) {
    if (parent is TextSpan) {
      return TextSpan(
        text: node.children.isEmpty ? parent.text : '',
        children: [
          ...parent.children ?? [],
          if (parent.text != null)
            ...node.children.map(
              (n) => _build(n, context, Tag._fromNode(n).build(context)),
            ),
        ],
        style: parent.style,
      );
    } else if (parent is WidgetSpan) {
      if (node.children.length > 1 ||
          (node.children.isNotEmpty && node.children.first is! XmlText)) {
        throw Exception(
          'A Tag that uses the WidgetSpan can only a single plain text child',
        );
      }
      return parent;
    }

    return TextSpan(
      children: node.children.map((n) {
        if (n.children.isNotEmpty) {
          return _build(n, context, Tag._fromNode(n).build(context));
        }
        return Tag._fromNode(n).build(context);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final xml = XmlDocument.parse('<body>$text</body>');
    return Text.rich(
      _build(xml.firstChild!, context),
      style: style,
      textAlign: textAlign,
    );
  }

  static void registerDefaultTags() {
    registerTag('icon', () => IconTag());
    registerTag('rainbow', () => RainbowTag());
    registerTag('style', () => StyleTag());
  }

  static void registerTag<T extends Tag>(String name, TagBuilder<T> builder) {
    Tag._tags[name] = () => builder();
  }
}
