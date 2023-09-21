// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class Appointment extends StatelessWidget {
//   const Appointment({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: IconThemeData.fallback(),
//         backgroundColor: Color.fromARGB(255, 241, 243, 247),
//         title: Text(
//           "Message",
//           style: TextStyle(
//             fontFamily: "Roboto Mono",
//             fontSize: 30,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//       ),
//       backgroundColor: Color.fromARGB(255, 241, 243, 247),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 color: Colors.white,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     border: InputBorder.none,
//                   ),
//                   onChanged: (text) {},
//                 ),
//               ),
//             ),
//           ),

//           Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(20.0), // Circular edges
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             'https://example.com/avatar.jpg'), // Replace with your image URL
//                       ),
//                       title: Text('John Doe'),
//                       subtitle: Text('Subtitle'),
//                       trailing: Text('10:00 AM'),
//                     ),
//                   ).px8(),

//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(20.0), // Circular edges
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             'https://example.com/avatar.jpg'), // Replace with your image URL
//                       ),
//                       title: Text('Jane Smith'),
//                       subtitle: Text('Another Subtitle'),
//                       trailing: Text('11:30 AM'),
//                     ),
//                   ).px8(),
//                   // Add more Card-wrapped ListTiles with circular edges on all sides
//                 ],
//               ),
//             ),
//           ).py16(),

// // Container(
// //   // Container is optional depending on your layout needs.
// //   // color: Colors.white,
// //   child: SingleChildScrollView(
// //     child: ListView.builder(
// //       shrinkWrap: true,
// //       itemCount: yourData.length, // Replace with the actual length of your data list.
// //       itemBuilder: (BuildContext context, int index) {
// //         // Access your data at the current index.
// //         var item = yourData[index];

// //         return Card(
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(20.0), // Circular edges
// //           ),
// //           child: ListTile(
// //             leading: CircleAvatar(
// //               backgroundImage: NetworkImage(item.imageUrl), // Replace with your image URL from the data.
// //             ),
// //             title: Text(item.name), // Replace with the name field from the data.
// //             subtitle: Text(item.subtitle), // Replace with the subtitle field from the data.
// //             trailing: Text(item.time), // Replace with the time field from the data.
// //           ).px8(),
// //         );
// //       },
// //     ),
// //   ),
// // ).py16(),
//         ],
//       ),
//     );
//   }
// }

// api

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:velocity_x/velocity_x.dart';

// class Appointment extends StatefulWidget {
//   @override
//   _AppointmentState createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {
//   List<Map<String, dynamic>> dataList = [];
//   List<Map<String, dynamic>> filteredData = [];

//   String searchText = '';

//   @override
//   void initState() {
//     fetchDataFromBackend(); // Fetch data from your backend when the widget initializes
//     super.initState();
//   }

//   Future<void> fetchDataFromBackend() async {
//     final response =
//         await http.get(Uri.parse('https://your-backend-api.com/data'));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       setState(() {
//         dataList = List<Map<String, dynamic>>.from(jsonData);
//         filteredData = dataList;
//       });
//     } else {
//       throw Exception('Failed to fetch data from the backend');
//     }
//   }

//   void filterData(String query) {
//     setState(() {
//       searchText = query;
//       if (query.isEmpty) {
//         filteredData = dataList;
//       } else {
//         filteredData = dataList.where((item) {
//           return item['name'].toLowerCase().contains(query.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   bool isCardHighlighted(String name) {
//     return name.toLowerCase().contains(searchText.toLowerCase());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20.0),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               color: Colors.white,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   prefixIcon: Icon(Icons.search),
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (text) {},
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: filteredData.length,
//             itemBuilder: (BuildContext context, int index) {
//               final item = filteredData[index];
//               return Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 color: isCardHighlighted(item['name'])
//                     ? Colors.yellow
//                     : Colors.white,
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(item['imageUrl']),
//                   ),
//                   title: Text(item['name']),
//                   subtitle: Text(item['subtitle']),
//                   trailing: Text(item['time']),
//                 ).px8(),
//               );
//             },
//           ),
//         ),
//       ],
//     ).py16();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class Appointment extends StatefulWidget {
//   const Appointment({Key? key}) : super(key: key);

//   @override
//   _AppointmentState createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {
//   final List<Map<String, dynamic>> dataList = [
//     {
//       'imageUrl': 'https://example.com/avatar1.jpg',
//       'name': 'John Doe',
//       'subtitle': 'Subtitle 1',
//       'time': '10:00 AM',
//     },
//     {
//       'imageUrl': 'https://example.com/avatar2.jpg',
//       'name': 'Jane Smith',
//       'subtitle': 'Another Subtitle',
//       'time': '11:30 AM',
//     },
//     // Add more data items as needed
//   ];

//   List<Map<String, dynamic>> filteredData = [];

//   String searchText = '';

//   @override
//   void initState() {
//     filteredData = dataList;
//     super.initState();
//   }

//   void filterData(String query) {
//     setState(() {
//       searchText = query;
//       if (query.isEmpty) {
//         filteredData = dataList;
//       } else {
//         filteredData = dataList.where((item) {
//           return item['name'].toLowerCase().contains(query.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: IconThemeData.fallback(),
//         backgroundColor: Color.fromARGB(255, 241, 243, 247),
//         title: Text(
//           "Message",
//           style: TextStyle(
//             fontFamily: "Roboto Mono",
//             fontSize: 30,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//       ),
//       backgroundColor: Color.fromARGB(255, 241, 243, 247),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 color: Colors.white,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     border: InputBorder.none,
//                   ),
//                   onChanged: filterData,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: filteredData.map((item) {
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     color: item['name']
//                             .toLowerCase()
//                             .contains(searchText.toLowerCase())
//                         ? Colors.white
//                         : Colors.white,
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(item['imageUrl']),
//                       ),
//                       title: Text(item['name']),
//                       subtitle: Text(item['subtitle']),
//                       trailing: Text(item['time']),
//                     ).px8(),
//                   ).px8();
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:appointment/pages/chat.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final List<Map<String, dynamic>> dataList = [
    {
      'imageUrl': 'https://example.com/avatar1.jpg',
      'name': 'John Doe',
      'subtitle': 'Subtitle 1',
      'time': '10:00 AM',
    },
    {
      'imageUrl': 'https://example.com/avatar2.jpg',
      'name': 'Jane Smith',
      'subtitle': 'Another Subtitle',
      'time': '11:30 AM',
    },
    // Add more data items as needed
  ];

  List<Map<String, dynamic>> filteredData = [];

  String searchText = '';

  @override
  void initState() {
    filteredData = dataList;
    super.initState();
  }

  void filterData(String query) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        filteredData = dataList;
      } else {
        filteredData = dataList.where((item) {
          return item['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Color.fromARGB(255, 241, 243, 247),
        title: Text(
          "Message",
          style: TextStyle(
            fontFamily: "Roboto Mono",
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 241, 243, 247),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: filterData,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: filteredData.map((item) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the chat screen when a card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(item['name']),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: item['name']
                              .toLowerCase()
                              .contains(searchText.toLowerCase())
                          ? Colors.white
                          : Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item['imageUrl']),
                        ),
                        title: Text(item['name']),
                        subtitle: Text(item['subtitle']),
                        trailing: Text(item['time']),
                      ).px8(),
                    ).px8(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//posible backend


// class Appointment extends StatefulWidget {
//   const Appointment({Key? key}) : super(key: key);

//   @override
//   _AppointmentState createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {
//   List<Map<String, dynamic>> messageList = []; // List to store messages

//   // Function to fetch messages from your AWS backend
//   Future<void> fetchMessages() async {
//     // Make an HTTP request to your backend API endpoint
//     final response = await http.get(Uri.parse('YOUR_BACKEND_API_ENDPOINT'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       setState(() {
//         messageList = List<Map<String, dynamic>>.from(data);
//       });
//     } else {
//       throw Exception('Failed to load messages');
//     }
//   }

//   @override
//   void initState() {
//     fetchMessages(); // Fetch messages when the widget is initialized
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Your existing code for UI

//     // Use the messageList to display messages in your UI
//     // Replace the static data with the fetched data

//     return Scaffold(
//       appBar: AppBar(
//         // ... Your existing app bar code ...
//       ),
//       backgroundColor: Color.fromARGB(255, 241, 243, 247),
//       body: Column(
//         children: [
//           Container(
//             // ... Your existing search bar code ...
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: messageList.map((item) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Navigate to the chat screen when a card is tapped
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChatScreen(item['name']),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       // ... Your existing card code ...
//                     ).px8(),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
