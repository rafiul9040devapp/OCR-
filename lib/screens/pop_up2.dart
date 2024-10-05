import 'package:flutter/material.dart';

class ActionMenuButton extends StatefulWidget {
  const ActionMenuButton({Key? key}) : super(key: key);

  @override
  State<ActionMenuButton> createState() => _ActionMenuButtonState();
}

class _ActionMenuButtonState extends State<ActionMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PopupMenuButton<int>(
          // Custom child button design
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.tealAccent[700], // Light teal background
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.add,
                  color: Colors.white, // White icon
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  " New",
                  style: TextStyle(
                    color: Colors.white, // White text
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Popup menu design
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              value: 1,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Black text
                  ),
                ),
                trailing: const Icon(Icons.add_box, color: Colors.black),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 2,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Upload",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red[200], // Semi-transparent red
                  ),
                ),
                leading: const Icon(Icons.upload, color: Colors.red),
              ),
            ),
          ],
          onSelected: (int value) {
            // Handle menu item clicks here
            if (value == 1) {
              print('Create selected');
            } else if (value == 2) {
              print('Upload selected');
            }
          },
        ),
      ),
    );
  }
}

