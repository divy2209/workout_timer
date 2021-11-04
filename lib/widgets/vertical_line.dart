import 'package:flutter/material.dart';

class VerticalLine extends StatelessWidget {
  const VerticalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(width: 0.5, height: 180, color: Colors.grey.withOpacity(0.3),),
    );
  }
}
