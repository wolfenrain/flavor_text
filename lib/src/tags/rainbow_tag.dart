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
class RainbowTag extends Tag {
  static final List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
  ];

  static final _gradient = LinearGradient(colors: _colors);

  @override
  InlineSpan build(BuildContext context) {
    return WidgetSpan(
      child: ShaderMask(
        shaderCallback: (bounds) => _gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
