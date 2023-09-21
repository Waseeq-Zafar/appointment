import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String name;

  ChatScreen(this.name);

  @override
  Widget build(BuildContext context) {
    // Example avatar image URL (replace with the actual URL)
    String avatarImageUrl = 'https://example.com/avatar.jpg';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 63, 246),
        titleSpacing:
            0.0, // Reduces the default horizontal spacing between the leading widget and the title
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align items to the start
          children: [
            // Circular avatar on the left
            CircleAvatar(
              backgroundImage: NetworkImage(avatarImageUrl),
              radius: 20,
            ),
            SizedBox(width: 8), // Add spacing
            // Name on the right
            Text(
              name,
              style: TextStyle(
                fontFamily: "Roboto Mono",
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: ChatWidget(name: name),
    );
  }
}

class ChatWidget extends StatefulWidget {
  final String name; // Add the 'name' parameter

  ChatWidget({required this.name});
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return MessageBubble(
                message: message,
              );
            },
          ),
        ),
        InputField(
          onMessageSent: (text) {
            setState(() {
              _messages.add(ChatMessage(
                text: text,
                isUser: true, // Set to true for user messages
              ));
              // Simulate a received message (replace this with actual incoming messages)
              _messages.add(ChatMessage(
                text: 'Hello, ${widget.name}!',
                isUser: false, // Set to false for received messages
              ));
            });
          },
        ),
      ],
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final bgColor = isUser ? Colors.blue : Colors.green;
    final alignment =
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft:
                    isUser ? Radius.circular(12.0) : Radius.circular(0.0),
                bottomRight:
                    isUser ? Radius.circular(0.0) : Radius.circular(12.0),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final Function(String) onMessageSent;

  InputField({required this.onMessageSent});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final messageText = _controller.text.trim();
              if (messageText.isNotEmpty) {
                widget.onMessageSent(messageText);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}


//possible backend


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ChatScreen extends StatefulWidget {
//   final String name;

//   ChatScreen(this.name);

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   List<ChatMessage> _messages = [];

//   // Function to fetch messages from your AWS backend
//   Future<void> fetchMessages() async {
//     // Make an HTTP request to your backend API endpoint
//     final response = await http.get(Uri.parse('YOUR_BACKEND_API_ENDPOINT'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       setState(() {
//         _messages = List<ChatMessage>.from(data.map((item) =>
//             ChatMessage(text: item['text'], isUser: item['isUser'])));
//       });
//     } else {
//       throw Exception('Failed to load messages');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Call the fetchMessages function when the widget is initialized
//     fetchMessages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Example avatar image URL (replace with the actual URL)
//     String avatarImageUrl = 'https://example.com/avatar.jpg';

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 50, 63, 246),
//         titleSpacing: 0.0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(avatarImageUrl),
//               radius: 20,
//             ),
//             SizedBox(width: 8),
//             Text(
//               widget.name,
//               style: TextStyle(
//                 fontFamily: "Roboto Mono",
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: ChatWidget(name: widget.name, messages: _messages),
//     );
//   }
// }

// class ChatWidget extends StatefulWidget {
//   final String name;
//   final List<ChatMessage> messages;

//   ChatWidget({required this.name, required this.messages});

//   @override
//   _ChatWidgetState createState() => _ChatWidgetState();
// }

// class _ChatWidgetState extends State<ChatWidget> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: widget.messages.length,
//             itemBuilder: (context, index) {
//               final message = widget.messages[index];
//               return MessageBubble(
//                 message: message,
//               );
//             },
//           ),
//         ),
//         InputField(
//           onMessageSent: (text) {
//             setState(() {
//               widget.messages.add(ChatMessage(
//                 text: text,
//                 isUser: true,
//               ));
//               // Simulate a received message (replace this with actual incoming messages)
//               widget.messages.add(ChatMessage(
//                 text: 'Hello, ${widget.name}!',
//                 isUser: false,
//               ));
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

// class ChatMessage {
//   final String text;
//   final bool isUser;

//   ChatMessage({
//     required this.text,
//     required this.isUser,
//   });
// }

// class MessageBubble extends StatelessWidget {
//   final ChatMessage message;

//   MessageBubble({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     final isUser = message.isUser;
//     final bgColor = isUser ? Colors.blue : Colors.green;
//     final alignment =
//         isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

//     return Container(
//       margin: EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: alignment,
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: bgColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12.0),
//                 topRight: Radius.circular(12.0),
//                 bottomLeft:
//                     isUser ? Radius.circular(12.0) : Radius.circular(0.0),
//                 bottomRight:
//                     isUser ? Radius.circular(0.0) : Radius.circular(12.0),
//               ),
//             ),
//             child: Text(
//               message.text,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InputField extends StatefulWidget {
//   final Function(String) onMessageSent;

//   InputField({required this.onMessageSent});

//   @override
//   _InputFieldState createState() => _InputFieldState();
// }

// class _InputFieldState extends State<InputField> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () {
//               final messageText = _controller.text.trim();
//               if (messageText.isNotEmpty) {
//                 widget.onMessageSent(messageText);
//                 _controller.clear();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
