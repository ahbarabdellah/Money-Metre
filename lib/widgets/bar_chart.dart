import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalSpending;
  final double percentage;
  const ChartBar(
      {required this.label,
      required this.totalSpending,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${totalSpending.toStringAsFixed(0)}'),
        const SizedBox(
          height: 4,
        ),
        Container(
            width: 10,
            height: 60,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        200,
                      ),
                    ),
                  ),
                ), // backgroung fraction container
                FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          200,
                        ),
                      ),
                    ),
                  ),
                ), // forward colored percentage
              ],
            )),
        const SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
