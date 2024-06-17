import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  final WebSocketChannel channel;
  const HomePage({super.key, required this.channel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            const Text(
              'Response from server:',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
              ),
            ),

            //*text we receive from server
            StreamBuilder(
              //*websocket channel
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.data ?? 'no data');
              },
            ),

            const Spacer(),

            //*text we send to the server
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Send a message',
                suffixIcon: IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
