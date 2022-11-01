import 'package:flutter/material.dart';

import 'package:analogclock_febriansyah/pages/widgets/w_angka.dart';
import 'package:analogclock_febriansyah/pages/widgets/w_circle.dart';
import 'package:analogclock_febriansyah/pages/widgets/w_jarum_detik.dart';
import 'package:analogclock_febriansyah/pages/widgets/w_jarum_jam.dart';
import 'package:analogclock_febriansyah/pages/widgets/w_jarum_menit.dart';
import 'package:intl/intl.dart';

class Jam extends StatefulWidget {
  const Jam({super.key});

  @override
  State<Jam> createState() => _JamState();
}

class _JamState extends State<Jam> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: Stream.periodic(
            const Duration(seconds: 1),
          ),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleJam(),
                      JarumDetik(),
                      JarumMenit(),
                      JarumJam(),
                      Container(
                        height: 16,
                        width: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      AngkaWidget()
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('hh:mm:ss a').format(DateTime.now()),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.now()),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
