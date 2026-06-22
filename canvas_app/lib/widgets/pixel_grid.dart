import 'package:flutter/material.dart';

class PixelGrid extends StatefulWidget {
  // TODO: you will need your DatabaseService here

  
  // TODO: (Nothing to do here, but read the explanation please)
  // ValueGetter is a callback that can return a value.
  // We already used a VoidCallback in assignment05 to communicate between widgets.
  // Depending on _what_ we want to communicate between widgets, Flutter has different options.
  // Here we want to be able to receive the currently selected color in ColorPalette via the canvas screen.
  final ValueGetter<Color> selectedColor;
  
  const PixelGrid({required this.selectedColor, super.key});

  @override
  State<PixelGrid> createState() => _PixelGridState();
}

class _PixelGridState extends State<PixelGrid> {
  // These values are known at compile-time, and are never changed.
  static const pixelsPerRow = 10;
  static const pixelsPerColumn = 10;
  static const numPixels = pixelsPerRow * pixelsPerColumn;

  late List<Color> currentColors;

  @override
  void initState() {
    super.initState();

    // Create a list to store all our pixels' colors. (default to white)
    currentColors = List.generate(numPixels, (_) => Colors.white);

    // TODO:
    // here you need to get the saved data from the database via your databaseService,
    // listen to data changes and update the colored pixels
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        // 10x10 grid size (we only specify that it does a "line break" after 10,
        // the number of rows comes from the size of our List itself.
        crossAxisCount: pixelsPerColumn,
        // Prevent PixelGrid from being scrollable
        physics: const NeverScrollableScrollPhysics(),

        children: List.generate(numPixels, (index) {
          return GestureDetector(
            onTap: () {
              debugPrint(
                'on pixel tap: at $index, color  ${widget.selectedColor}',
              );

              // Update UI immediately (otherwise we have a delay)
              setState(() {
                currentColors[index] = widget.selectedColor();
              });

              // TODO: the save index and color to DB via widget.databaseService
            },
            child: Container(
              // Automatically scale the pixels relative to our screen size.
              width: MediaQuery.sizeOf(context).width / 10,
              height: MediaQuery.sizeOf(context).width / 10,
              decoration: BoxDecoration(
                color: currentColors[index],
                // Hide border by making it size zero.
                border: Border.all(width: 0, color: currentColors[index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
