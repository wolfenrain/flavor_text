part of flavor_text;

/// Tag for displaying icons as text.
///
/// By using the icon name as the text and setting the fontFamily
/// to MaterialIcons wen we can render icons as text.
///
/// See [Icons] for a list of icons that are supported.
///
/// ```dart
/// final text1 = '<icon>home</icon>';
/// final text2 = '<icon>phone</icon>';
/// ```
class IconTag extends Tag {
  @override
  List<String> get supportedProperties => ['family'];

  @override
  InlineSpan build(BuildContext context) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: when(properties['family'], {
          'CupertinoIcons': () => 'CupertinoIcons',
        }).orElse(() => 'MaterialIcons'),
      ),
    );
  }
}
