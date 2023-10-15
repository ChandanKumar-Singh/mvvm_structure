import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '../../chat_app/home_page.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const ChatHomePage(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic'),
      ),
      body: ListView(
        children: [
          ...Iterable.generate(
            100,
            (i) => ListTile(
              title: Text('Tile $i'),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}