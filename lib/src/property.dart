part of flavor_text;

/// A property belonging to a [Tag].
class Property {
  /// Name of the property.
  final String name;

  /// The value of the property.
  final String value;

  Property._(this.name, this.value);

  static Property _fromAttribute(XmlAttribute attribute) {
    return Property._(attribute.name.local, attribute.value);
  }
}
