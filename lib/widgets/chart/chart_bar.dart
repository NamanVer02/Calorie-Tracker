import 'package:calorie_tracker/main.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  const ChartBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Padding( 
        padding: const EdgeInsets.all(10),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: kColorScheme.onPrimaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );
  }
}