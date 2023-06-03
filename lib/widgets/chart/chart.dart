import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/models/expense.dart';
import 'package:calorie_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.foods});

  final List<Expense> foods;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(foods, Category.breakfast),
      ExpenseBucket.forCategory(foods, Category.lunch),
      ExpenseBucket.forCategory(foods, Category.dinner),
    ];
  }

  double get maxTotalCalories {
    double maxTotalCalories = 0;

    for (final bucket in buckets) {
      if (bucket.totalCalories > maxTotalCalories) {
        maxTotalCalories = bucket.totalCalories;
      }
    }

    return maxTotalCalories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalCalories == 0
                        ? 0
                        : bucket.totalCalories / maxTotalCalories,
                  ),
              ],
            ),
          ),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: kColorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
