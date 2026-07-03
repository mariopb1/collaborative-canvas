import 'package:flutter/material.dart';
import 'dart:async';
import 'package:canvas_app/database/database_service.dart';

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

  final DatabaseService databaseService = DatabaseService();
  StreamSubscription? _pixelStreamSubscription;

  @override
  void initState() {
    super.initState();

    // Grid initial mit weißen Pixels füllen
    currentColors = List.generate(numPixels, (_) => Colors.white);

    _pixelStreamSubscription = databaseService.getPixelStream().listen((
      snapshot,
    ) {
      // Supabase schickt uns eine Liste aller Pixel-Einträge
      for (var entry in snapshot) {
        int currentId = entry['id'];
        int currentColorAsInt = entry['color'];
        Color currentColor = Color(currentColorAsInt);

        // Wenn die ID gültig ist und sich die Farbe wirklich geändert hat, updaten wir das UI
        if (currentId >= 0 &&
            currentId < numPixels &&
            currentColors[currentId] != currentColor) {
          setState(() {
            currentColors[currentId] = currentColor;
          });
        }
      }
    });
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
