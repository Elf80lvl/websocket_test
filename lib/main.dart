import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:websocket_test/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Websocket demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: HomePage(
        channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
      ),
    );
  }
}
