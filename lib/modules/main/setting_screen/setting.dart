export 'setting_controller.dart';
export 'setting_binding.dart';
export 'setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FontListScreen(),
    );
  }
}

class FontListScreen extends StatefulWidget {
  @override
  _FontListScreenState createState() => _FontListScreenState();
}

class _FontListScreenState extends State<FontListScreen> {
  TextEditingController textController = TextEditingController();
  List<String> fontFamilies = GoogleFonts.asMap().keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Font List Generator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Enter Text'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text('Generate Font List'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fontFamilies.length,
              itemBuilder: (context, index) {
                final fontFamily = fontFamilies[index];
                return Text(
                  textController.text,
                  style: GoogleFonts.getFont(fontFamily),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
