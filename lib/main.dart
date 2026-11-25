
import 'package:flutter/material.dart';

void main() {
  runApp(const JobHubApp());
}

class JobHubApp extends StatelessWidget {
  const JobHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobHub',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('JobHub'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text(
            'Welcome to JobHub!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
