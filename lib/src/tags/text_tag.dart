part of flavor_text;

/// Tag for normal text.
class TextTag extends Tag {
  @override
  List<String> get supportedProperties => [];

  @override
  InlineSpan build(BuildContext context) => TextSpan(text: text);
}
