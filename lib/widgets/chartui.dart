import 'package:flutter/material.dart';

// ignore: camel_case_types
class chart extends StatelessWidget {
  const chart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 213, 202, 247),
      ),
      margin: const EdgeInsets.all(10),
      height: 200,
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 236, 150, 251),
            ),
            margin: const EdgeInsets.all(10),
            height: 200,
            width: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 236, 150, 251),
            ),
            margin: const EdgeInsets.all(10),
            height: 200,
            width: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 236, 150, 251),
            ),
            margin: const EdgeInsets.all(10),
            height: 200,
            width: 50,
          ),
        ],
      ),
    );
  }
}
