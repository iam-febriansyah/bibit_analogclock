import 'package:flutter/material.dart';

class CircleJam extends StatelessWidget {
  const CircleJam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isPortait = height > width;
    return Container(
      height: isPortait ? height * 0.5 : height * 0.6,
      width: width * 0.7,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 55, 55, 79),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
