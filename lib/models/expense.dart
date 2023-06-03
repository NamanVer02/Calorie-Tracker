import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { breakfast, lunch, dinner }

final formatter = DateFormat.MMMEd();

const categoryIcons = {
  Category.breakfast: Icons.sunny,
  Category.lunch: Icons.lunch_dining,
  Category.dinner: Icons.mode_night,
};

class Expense {
  Expense(
      {required this.title,
      required this.calories,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final int calories; 
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.foods,
  });

  ExpenseBucket.forCategory(List<Expense> allFoods, this.category)
      : foods = allFoods.where((food) => food.category == category).toList();

  final Category category;
  final List<Expense> foods;

  double get totalCalories {
    double sum = 0;
    for (final food in foods) {
      sum += food.calories;
    }
    return sum;
  }
}
