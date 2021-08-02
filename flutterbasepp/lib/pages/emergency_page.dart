import 'package:flutter/material.dart';
import 'package:flutterbasepp/widgets/header.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconHeader(
        icon: Icons.alarm,
        title: 'Title',
        subTitle: 'Subtitulo',
      ),
    );
  }
}
