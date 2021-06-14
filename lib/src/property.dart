part of flavor_text;

/// A property belonging to a [Tag].
class Property {
  /// Name of the property.
  final String name;

  /// If it is a required property.
  final bool required;

  /// The value of the property.
  late final String value;

  Property(this.name, {this.required = false});

  Property _withValue(String value) {
    return Property(name, required: required)..value = value;
  }
}
