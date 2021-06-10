part of flavor_text;

/// Tag for adding icons as text (not as widget).
/// 
/// By parsing the [IconData.codePoint] as a char code and setting the 
/// fontFamily to the [IconData.fontFamily] we can render icons as text.
/// 
/// ```dart
/// final text1 = '<icon>home</icon>';
/// final text2 = '<icon>phone</icon>';
/// ```
class IconTag extends Tag {
  @override
  List<String> get supportedProperties => [];

  @override
  InlineSpan build(BuildContext context) {
    final icon = when(text, {
      'threesixty': () => Icons.threesixty,
      'home': () => Icons.home,
      'phone': () => Icons.phone,
    });

    if (icon == null) {
      return TextSpan();
    }

    return TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(fontFamily: icon.fontFamily),
    );
  }
}
