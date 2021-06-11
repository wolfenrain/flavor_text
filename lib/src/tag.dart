part of flavor_text;

/// Base class that each tag should extend from.
///
/// Default tags provided:
/// - [StyleTag] for styling text.
/// - [IconTag] for adding an icon to the text.
abstract class Tag {
  /// The properties this tag supports.
  ///
  /// Override this with the list of properties your tag is supporting.
  List<Property> get supportedProperties => [];

  /// Name of the tag.
  ///
  /// Example:
  ///
  /// ```
  /// <the_tag_name>optional text</the_tag_name>
  /// ```
  String get name => _name;
  late final String _name;

  /// The text in the tag.
  ///
  /// **Note**: Will be an empty string if the tag has children.
  ///
  /// Example:
  ///
  /// ```
  /// <tag_name>The tag text</tag_name>
  /// ```
  String get text => _text;
  late final String _text;

  /// List of properties for the tag.
  ///
  /// Example:
  ///
  /// ```
  /// <tag_name property1='value1' property2='value2'>optional text</tag_name>
  /// ```
  Map<String, Property> get properties => UnmodifiableMapView(_properties);
  Map<String, Property> _properties = {};

  /// Build method for the tag.
  InlineSpan build(BuildContext context);

  /// Registered tags.
  static final Map<String, TagBuilder> _tags = {};

  /// Converts given [node] into a [Tag].
  ///
  /// If the [node] is not an [XmlElement] but is a [XmlText] then it gets
  /// turned into a [TextTag].
  static Tag _fromNode(XmlNode node) {
    late Tag tag;
    if (node is XmlElement) {
      if (!_tags.containsKey(node.name.local)) {
        throw Exception('''
No tag found with the name "${node.name.local}".

Register your custom tag like so: Tag.registerTag("${node.name.local}", () => YourTag())
''');
      }
      tag = _tags[node.name.local]!();
      tag._name = node.name.local;
      tag._text =
          node.children.length == 1 && node.children.first is! XmlElement
              ? node.text
              : '';

      final properties = <Property>[];
      for (final property in tag.supportedProperties.where((p) => p.required)) {
        final attribute =
            node.attributes.firstOrNull((a) => a.name.local == property.name);
        if (attribute == null) {
          throw Exception(
            'Required property "${property.name}" not found on "${tag.name}"',
          );
        }
      }

      for (final attribute in node.attributes) {
        final property = tag.supportedProperties
            .firstOrNull((p) => attribute.name.local == p.name);

        if (property == null) {
          throw Exception(
            'Property "${attribute.name.local}" is not supported on the "${tag.name}" tag',
          );
        }

        properties.add(property._withValue(attribute.value));
      }
      tag._properties = properties.associateBy((prop) => prop.name);
    } else if (node is XmlText) {
      tag = TextTag();
      tag._text = node.text;
    }

    return tag;
  }
}
