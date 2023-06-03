import 'package:calorie_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.MMMEd();

class NewFood extends StatefulWidget {
  const NewFood({super.key, required this.onAddFood});

  final void Function(Expense expense) onAddFood;

  @override
  State<NewFood> createState() {
    return _NewFoodState();
  }
}

class _NewFoodState extends State<NewFood> {
  final _textController = TextEditingController();
  final _calorieController = TextEditingController();
  Category _selectedCategory = Category.breakfast;
  DateTime? _selectedDate;

  void _showDatePicker() async {
    final dateNow = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(dateNow.year - 1, dateNow.month, dateNow.day),
      lastDate: dateNow,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveData() {
    final caloriesAmount = int.tryParse(_calorieController.text);
    if (_textController.text.isEmpty ||
        caloriesAmount == null ||
        caloriesAmount < 0 ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please enter a valid title, calorie amount, category and date'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Close')),
          ],
        ),
      );
      return;
    }

    widget.onAddFood(Expense(
        title: _textController.text,
        calories: caloriesAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    _calorieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
            bottom: 20 + keyboardSpace,
          ),
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _calorieController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Calories',
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _textController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Title', 
                  ),
                ),
              if (width >= 600)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(_selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _showDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                DropdownButton(
                                    value: _selectedCategory,
                                    items: Category.values
                                        .map(
                                          (category) => DropdownMenuItem(
                                            value: category,
                                            child: Text(
                                              '${category.name.toString()[0].toUpperCase()}${category.name.substring(1).toLowerCase()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      if (value == null) {
                                        return;
                                      }
                                      setState(() {
                                        _selectedCategory = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                ElevatedButton(
                                    onPressed: _saveData,
                                    child: const Text('Save')),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _calorieController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Calories',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _showDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
              if(width < 600)
                const SizedBox(
                  height: 20,
                ),
              
              if(width < 600)
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DropdownButton(
                              value: _selectedCategory,
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        '${category.name.toString()[0].toUpperCase()}${category.name.substring(1).toLowerCase()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedCategory = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                              onPressed: _saveData, child: const Text('Save')),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
