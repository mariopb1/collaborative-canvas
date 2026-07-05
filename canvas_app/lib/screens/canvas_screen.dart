import 'package:canvas_app/authentication/auth_service.dart';
import 'package:canvas_app/screens/login_screen.dart';
import 'package:canvas_app/widgets/color_palette.dart';
import 'package:canvas_app/widgets/pixel_grid.dart';
import 'package:flutter/material.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  // The currently selected color that pixels will be changed to when tapping them (initially green).
  Color selectedColor = Colors.green;

  @override
  void initState() {
    super.initState();
  }

  // This is called from ColorPalette to update the selected color.
  // The selected color is also in for PixelGrid for drawing.
  void _changeSelectedColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  // This is called when pressing the "Logout"-Button in the top right.
  Future<void> logout() async {
    final authService = AuthService();

    // TODO: log out your user here using your AuthService
    // Erledigt: Wenn wir auf den Icon clicken, dann erscheint der Text unten und der User ist ausgellogt, was dann später von auth_gate
    // als Info bekommen wird.
    final loggedOut = await authService.signOut();

    // TODO:
    // for now we redirect the user to the login screen here
    // in your solution the AuthGate will handle this navigation, you need to remove it here
    // Erledigt: die variable loggedOut bekommt die State logged out und zeigt sofort den Loginscreen
    if (loggedOut != true) {
      debugPrint("Logout fehlgeschlagen");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout successful! Redirecting to login...')),
    );

    // TODO:
    // for now we redirect the user to the login screen here
    // in your solution the AuthGate will handle this navigation, you need to remove it here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canvas'),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          SizedBox(
            // Set fixed height -> PixelGrid is a square, so same as width
            height: MediaQuery.sizeOf(context).width,
            child: PixelGrid(
              // We pass a "ValueGetter" Method, which allows the PixelGrid to always get the current selected color.
              selectedColor: () => selectedColor,
            ),
          ),
          // Passing the currently selected color, and a valueSetter to change the color.
          ColorPalette(
            selectedColor: selectedColor,
            setSelectedColor: (color) => _changeSelectedColor(color),
          ),
        ],
      ),
    );
  }
}
