library flavor_text;

import 'dart:collection';

import 'package:dartlin/dartlin.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

part 'src/tags/icon_tag.dart';
part 'src/tags/style_tag.dart';
part 'src/tags/text_tag.dart';
part 'src/property.dart';
part 'src/tag.dart';

typedef TagBuilder<T extends Tag> = T Function();

class FlavorText extends StatefulWidget {
  final String text;

  final TextStyle? style;

  final TextAlign? textAlign;

  FlavorText(
    this.text, {
    this.style,
    this.textAlign,
  });

  @override
  _FlavorTextState createState() => _FlavorTextState();

  static void registerDefaultTags() {
    registerTag('style', () => StyleTag());
    registerTag('icon', () => IconTag());
  }

  static void registerTag<T extends Tag>(String name, TagBuilder<T> builder) {
    Tag._tags[name] = () => builder();
  }
}

class _FlavorTextState extends State<FlavorText> {
  late XmlDocument xml;

  @override
  void initState() {
    super.initState();
    xml = XmlDocument.parse('<body>${widget.text}</body>');
  }

  InlineSpan _build(XmlNode node, [InlineSpan? parent]) {
    if (parent is TextSpan) {
      return TextSpan(
        text: node.children.isEmpty ? parent.text : '',
        children: [
          ...parent.children ?? [],
          ...node.children.map(
            (n) => _build(n, Tag._fromNode(n).build(context)),
          ),
        ],
        style: parent.style,
      );
    }

    return TextSpan(
      children: node.children.map((n) {
        if (n.children.isNotEmpty) {
          return _build(n, Tag._fromNode(n).build(context));
        }
        return Tag._fromNode(n).build(context);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      _build(xml.firstChild!),
      style: widget.style,
      textAlign: widget.textAlign,
    );
  }
}
