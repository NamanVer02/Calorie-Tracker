import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/widgets/chart/chart.dart';
import 'package:calorie_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:calorie_tracker/widgets/new_food.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker/models/expense.dart';
import 'package:flutter/services.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regFoods = [];

  void _addFood(food) {
    setState(() {
      _regFoods.add(food);
    });
  }

  void _removeFood(food) {
    final index = _regFoods.indexOf(food);
    setState(() {
      _regFoods.remove(food);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Food Removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _regFoods.insert(index, food);
          });
        },
      ),
    ));
  }

  void _newExpenseOverlay() {
    final width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ],
          ),
        ),
        height: (width < 600)
            ? MediaQuery.of(ctx).size.height * 0.75
            : MediaQuery.of(ctx).size.height,
        child: NewFood(onAddFood: _addFood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text('No calories added yet'));
    if (_regFoods.isNotEmpty) {
      mainContent =
          ExpensesList(expenses: _regFoods, onRemoveFood: _removeFood);
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Calorie Tracker'), actions: [
          IconButton(
            onPressed: _newExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ]),
        body: (width < 600)
            ? Column(
                children: [
                  Chart(foods: _regFoods),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(foods: _regFoods)),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
