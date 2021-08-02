import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {
  const IconHeader({
    required this.icon,
    required this.title,
    required this.subTitle,
    this.color1 = Colors.pink,
    this.color2 = Colors.purple,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    final Color colorWhite = Colors.white.withOpacity(0.7);

    return Stack(
      children: [
        _IconHeaderBackground(),
        Positioned(
          top: -50,
          left: -70,
          child: FaIcon(
            FontAwesomeIcons.plus,
            size: 250,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 80,
              width: double.infinity,
            ),
            Text(
              'Haz solicitado',
              style: TextStyle(
                fontSize: 20,
                color: colorWhite,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Asistencia medica',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: colorWhite,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FaIcon(
              FontAwesomeIcons.plus,
              size: 80,
              color: Colors.white.withOpacity(0.2),
            ),
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  const _IconHeaderBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff526BF6),
              Color(0xff67ACF2),
            ],
          )),
    );
  }
}
