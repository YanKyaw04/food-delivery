import 'package:fancy_button_demo/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Package Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fancy Buttons Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyButton(
              text: 'Default Fancy Button',
              onPressed: () => showSnackBar(context, msg: "Default Button Pressed"),
            ),
            const SizedBox(height: 20),
            FancyButton(
              text: 'With Icon',
              icon: Icons.star,
              gradient: const LinearGradient(colors: [Colors.orange, Colors.red]),
              onPressed: () => showSnackBar(context, msg: "Icon Button Pressed"),
            ),
            const SizedBox(height: 20),
            FancyButton(
              text: 'Custom Radius & Elevation',
              borderRadius: 30,
              elevation: 8,
              gradient: const LinearGradient(colors: [Colors.green, Colors.teal]),
              onPressed: () => showSnackBar(context, msg: 'Custom button pressed'),
            ),
          ],
        ),
      ),
    );
  }
}
