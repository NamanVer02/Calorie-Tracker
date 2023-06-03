import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/widgets/chart/chart.dart';
import 'package:calorie_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:calorie_tracker/widgets/new_food.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker/models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _regFoods = [
    Expense(
      title: 'Rice',
      calories: 250,
      date: DateTime.now(),
      category: Category.breakfast
    ),

    Expense(
      title: 'Fruits',
      calories: 100,
      date: DateTime.now(),
      category: Category.lunch
    ),

    Expense(
      title: 'Fish',
      calories: 800,
      date: DateTime.now(),
      category: Category.dinner
    ),
  ];
  
  void _addFood(food){
    setState(() {
      _regFoods.add(food);
    });
  }

  void _removeFood(food){
    final index = _regFoods.indexOf(food);
    setState(() {
      _regFoods.remove(food);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Food Removed'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              _regFoods.insert(index, food);
            });
          },
        ),
      )
    );
  }

  void _newExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => Container(
        color: kColorScheme.onPrimaryContainer.withOpacity(0.2),
        height: MediaQuery.of(ctx).size.height * 0.75,
        child: NewFood(onAddFood: _addFood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No calories added yet'));
    if(_regFoods.isNotEmpty){
      mainContent = ExpensesList(expenses: _regFoods, onRemoveFood: _removeFood);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Tracker'),
        actions: [
          IconButton(
            onPressed: _newExpenseOverlay, 
            icon: const Icon(Icons.add),
          )
        ]
      ),
      body: Column(
        children: [
          Chart(foods: _regFoods),
          Expanded(child: mainContent),
        ],
      )
    );
  }
}