part of flavor_text;

/// Tag for normal text.
class TextTag extends Tag {
  @override
  InlineSpan build(BuildContext context) => TextSpan(text: text);
}
