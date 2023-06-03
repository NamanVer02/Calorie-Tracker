import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveFood});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveFood;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) =>
          Dismissible(
          key: ValueKey(expenses[index]), 
          onDismissed: (direction) {onRemoveFood(expenses[index]);},
          background: Container(
            color: kColorScheme.error.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            // child: const Icon(Icons.cancel_outlined),
          ),
          child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
