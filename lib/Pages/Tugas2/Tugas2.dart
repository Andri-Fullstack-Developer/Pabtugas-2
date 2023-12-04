// ignore_for_file: unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pab/Pages/Tugas2/Detaipage/DetailUser.dart';

class Tugas2 extends StatefulWidget {
  const Tugas2({super.key});

  @override
  State<Tugas2> createState() => _Tugas2State();
}

class _Tugas2State extends State<Tugas2> {
  final String apUrl = 'https://reqres.in/api/users?per_page=20';

  Future<List<dynamic>> __fecthData() async {
    var result = await http.get(Uri.parse(apUrl));
    if (result.statusCode == 200) {
      return json.decode(result.body)['data'];
    } else {
      throw Exception('Failed to load album');
    }
  }

  void _navigateToDetailPage(BuildContext context, dynamic userData) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 2),
        pageBuilder: (_, __, ___) => DetailPage(userData: userData),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar API'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 34, 61, 54),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: __fecthData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length * 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index.isOdd) {
                      return Divider(
                        thickness: 2.0,
                        color: const Color.fromARGB(255, 242, 250, 254),
                      );
                    }

                    final dataIndex = index ~/ 2;

                    return ListTile(
                      onTap: () {
                        _navigateToDetailPage(
                            context, snapshot.data[dataIndex]);
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          snapshot.data[dataIndex]['avatar'],
                        ),
                      ),
                      title: Text(
                        snapshot.data[dataIndex]['first_name'] +
                            " " +
                            snapshot.data[dataIndex]['last_name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data[dataIndex]['email'],
                        style: TextStyle(
                          color: const Color.fromARGB(105, 213, 250, 201),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  
  final dynamic userData;

  const DetailPage({Key? key, required this.userData}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Color.fromRGBO(178, 201, 206, 1)),
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 5,
          child: Container(
            width: 300,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder: (_, __, ___) => HoverImg(
                            imageUrl: userData['avatar'],
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "ContohTag",
                      child: ClipRRect(
                       borderRadius: BorderRadius.circular(100.0), 
                        child: Image.network(
                          userData['avatar'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${userData['first_name']} ${userData['last_name']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${userData['email']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(MdiIcons.linkedin),
                      SizedBox(width: 16),
                      Icon(MdiIcons.instagram),
                      SizedBox(width: 16),
                      Icon(MdiIcons.email),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HoverImg extends StatelessWidget {
  final String imageUrl;

  HoverImg({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Halaman Kedua'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: "ContohTag",
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
