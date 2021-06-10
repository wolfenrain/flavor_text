# Flavor Text
[![plugin version](https://img.shields.io/pub/v/flavor_text?label=pub)](https://pub.dev/packages/flavor_text)
[![coverage report](https://gitlab.com/wolfenrain/flavor_text/badges/main/coverage.svg)](https://gitlab.com/wolfenrain/flavor_text/-/commits/main)
[![pipeline status](https://gitlab.com/wolfenrain/flavor_text/badges/main/pipeline.svg)](https://gitlab.com/wolfenrain/flavor_text/-/commits/main)
[![dependencies](https://img.shields.io/librariesio/release/pub/flavor_text?label=dependencies)](https://gitlab.com/wolfenrain/flavor_text/-/blob/main/pubspec.yaml)

A lightweight and fully customisable text parser for Flutter.

> Flavor text is often the last text on a card or on the rear of a toy card or 
package, and is usually printed in italics or written between quotes to 
distinguish it from game-affecting text.

## Installation

Add `flavor_text` as a dependency in your pubspec.yaml file 
([what?](https://flutter.io/using-packages/)).

## Docs & API

See the [API Docs](https://pub.dev/documentation/flavor_text/latest/flavor_text/flavor_text-library.html) 
for detailed information on how to use Flavor Text.


## Usage

Flavor Text allows you to create custom rich text using strings. You don't have 
to mess with `Text.rich` and `TextSpan`'s. Just you, your text and a single 
widget.

### Basic Usage

Before you can start using Flavor Text you will need to register the Tag 
components that you are gonna use.

Flavor Text uses these Tag components to build your custom rich text. Flavor 
Text comes with a few [default Tag components](https://gitlab.com/wolfenrain/flavor_text/-/tree/main/lib/src/tags).

To use the default tags you need to register them first, thankfully Flavor Text 
has a method for that:

```dart
void main() {
    FlavorText.registerDefaultTags();
    
    ...
}
```
 
Now that the default tags are registered you can start using them. First you 
need to define the rich text you want to use as a string:

```dart
final richText = 'Hello <style color="0xFFFF0000">world</style>';
```

We have now created a string with some custom styling, and we can use that 
string in our Widget tree like so:
 
```dart
@override
Widget build(BuildContext context) {
    return Column(
        children: [
            ...
            
            FlavorText(richText),
            
            ...
        ],
    );
}
```

Which will render the text `Hello world` with the word `world` in red.

The `FlavorText` widget also accepts extra arguments for default styling 
and text alignment:

```dart
FlavorText(
    richText,
    style: TextStyle(
        color: Colors.green,
    ),
    textAlign: TextAlign.center,
)
```

You can also nest multiple tags, example:

```dart
final richText = 'Hello <style color="0xFFFF0000">world and <style weight="bold">you</style></style>!';
```

### Advanced Usage

If the default Tag components are not suitable for your needs or you need 
something specifically tailored to your usecase, you can easily create and 
register your own tag. 

First you need to create your own tag, for this example we will create a tag 
that add the `Icons.help` icon in our text.

```dart
class HelpTag extends Tag {
  @override
  List<String> get supportedProperties => [];
  
  @override
  InlineSpan build(BuildContext context) {
    return WidgetSpan(child: Icon(Icons.help));
  }
}
```

You can then register it:

```dart
void main() {
    ...

    // The first argument is the tag key.
    FlavorText.registerTag('help', () => HelpTag());

    ...
}
```

Now that our new tag is registered we can use it in our text:

```dart
FlavorText('This text will end in an icon <help></help>');

// Or using self-closing syntax
FlavorText('This text will end in an icon <help/>');
```
