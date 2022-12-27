import 'package:flutter/material.dart';
import 'package:selectable_box/selectable_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSelected_1 = false;
  bool isSelected_2 = false;
  bool isSelected_3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          const Center(
            child: Text(
              'Selectable Box',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SelectableBox(
            height: 250,
            onTap: () {
              setState(() {
                isSelected_1 = !isSelected_1;
              });
            },
            isSelected: isSelected_1,
            child: const Image(
              image: AssetImage('assets/images/1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          SelectableBox(
            height: 250,
            onTap: () {
              setState(() {
                isSelected_2 = !isSelected_2;
              });
            },
            isSelected: isSelected_2,
            child: const Image(
              image: AssetImage('assets/images/2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          SelectableBox(
            height: 250,
            onTap: () {
              setState(() {
                isSelected_3 = !isSelected_3;
              });
            },
            isSelected: isSelected_3,
            child: const Image(
              image: AssetImage('assets/images/3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
