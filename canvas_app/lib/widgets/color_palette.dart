import 'package:flutter/material.dart';

class ColorPalette extends StatelessWidget {
  // Callback to change the selected color (in canvas_screen.dart).
  // TODO: (Nothing to do here, but read the explanation please)
  // ValueSetter is a callback that can set a value.
  // We already used a VoidCallback in assignment05 to communicate between widgets.
  // Depending on _what_ we want to communicate between widgets, Flutter has different options.
  // Here we want to be able to trigger a change of the selected color in ColorPalette that the canvas screen needs to know about.
  
  final ValueSetter setSelectedColor;

  final Color selectedColor;

  const ColorPalette({
    required this.setSelectedColor,
    required this.selectedColor,
    super.key,
  });

  static const double pixelSize = 5;
  static const List colorList = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.brown,
    Colors.black,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.cyan,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: GridView.count(
          // Our color palette has 4 boxes in a row.
          crossAxisCount: 4,
          children: List.generate(
            colorList.length,
            (index) => GestureDetector(
              onTap: () => setSelectedColor(colorList[index]),
              child: Container(
                margin: EdgeInsets.all(10),
                width: pixelSize,
                height: pixelSize,
                decoration: BoxDecoration(
                  color: colorList[index],
                  border: Border.all(
                    color: (selectedColor == colorList[index])
                        ? Colors.red
                        : Colors.white,
                    width: 5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
