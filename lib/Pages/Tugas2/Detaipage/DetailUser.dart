import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar Routing'),
      ),
      body: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder: (_, __, ___) => AboutPage(),
            ),
          );
        },
        child: Hero(
          tag: "ContohTag",
          child: Image.network(
            'https://th.bing.com/th/id/OIG.ey_KYrwhZnirAkSgDhmg',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Kedua'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: "ContohTag",
            child: Image.network(
                'https://th.bing.com/th/id/OIG.ey_KYrwhZnirAkSgDhmg'),
          ),
        ),
      ),
    );
  }
}
