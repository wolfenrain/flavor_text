part of flavor_text;

/// Tag for styling text.
///
/// ```dart
/// final text1 = '<style color="primaryColor" fontWeight="w600" fontSize="24">Styled text</style>';
/// final text2 = '<style color="0xFFFF0000" fontWeight="bold" fontSize="8.5">Styled text</style>';
/// ```
class StyleTag extends Tag {
  static final fontWeights = {
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
    'normal': () => FontWeight.normal,
  };

  @override
  List<Property> get supportedProperties => [
        Property('color'),
        Property('fontWeight'),
        Property('fontSize'),
        Property('letterSpacing'),
        Property('fontFamily'),
      ];

  TextStyle textStyle(BuildContext context) {
    return TextStyle(
      color: iff(properties['color'] != null, () {
        return when(properties['color']!.value, {
          'primaryColor': () => Theme.of(context).primaryColor,
          'accentColor': () => Theme.of(context).colorScheme.secondary,
        }).orElse(() => Color(int.parse(properties['color']!.value)));
      }),
      fontWeight: when(properties['fontWeight']?.value, fontWeights),
      fontSize: properties['fontSize'] != null
          ? double.parse(properties['fontSize']!.value)
          : null,
      letterSpacing: properties['letterSpacing'] != null
          ? double.parse(properties['letterSpacing']!.value)
          : null,
      fontFamily: properties['fontFamily']?.value,
    );
  }

  @override
  InlineSpan build(BuildContext context) {
    return TextSpan(text: text, style: textStyle(context));
  }
}
