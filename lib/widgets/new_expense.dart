import 'package:flutter/material.dart';
import 'package:test_proj/model/Expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDateButton() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 126, now.month, now.day);
    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);

    setState(() {
      _selectedDate = pickDate;
    });
  }

  void submitExpenseData() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final amountIsInvalid = enteredamount == null || enteredamount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'please make sure a valid ,amount,date and time was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('okay'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titlecontroller.text,
        amount: enteredamount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final KeyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, KeyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titlecontroller,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titlecontroller,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 24,
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
                              onPressed: _presentDateButton,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ))
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
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
                              onPressed: _presentDateButton,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ))
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitExpenseData,
                          child: const Text('save Expense')),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitExpenseData,
                          child: const Text('save Expense')),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
