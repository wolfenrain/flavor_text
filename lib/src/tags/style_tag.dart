part of flavor_text;

/// Tag for styling text.
/// 
/// ```dart
/// final text1 = '<style color="primaryColor" weight="w600" size="24">Styled text</style>';
/// final text2 = '<style color="0xFFFF0000" weight="bold" size="8.5">Styled text</style>';
/// ```
class StyleTag extends Tag {
  @override
  List<String> get supportedProperties => ['color', 'weight', 'size'];

  @override
  InlineSpan build(BuildContext context) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: iff(properties['color'] != null, () {
          return when(properties['color'], {
            'primaryColor': () => Theme.of(context).primaryColor,
            'accentColor': () => Theme.of(context).accentColor,
          }).orElse(() => Color(int.parse(properties['color']!.value)));
        }),
        fontWeight: when(properties['weight'], {
          'w100': () => FontWeight.w100,
          'w200': () => FontWeight.w200,
          'w300': () => FontWeight.w300,
          'w400': () => FontWeight.w400,
          'w500': () => FontWeight.w500,
          'w600': () => FontWeight.w600,
          'w700': () => FontWeight.w700,
          'w800': () => FontWeight.w800,
          'w900': () => FontWeight.w900,
          'bold': () => FontWeight.bold,
        }),
        fontSize: properties['size'] != null
            ? double.parse(properties['size']!.value)
            : null,
      ),
    );
  }

}
