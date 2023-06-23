import 'package:flutter/material.dart';
import 'package:test_proj/model/Expense.dart';
import 'package:test_proj/widgets/expenses_list/expenses_list.dart';
import 'package:test_proj/widgets/new_expense.dart';
import 'chartui.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseindex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseindex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found,start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        onRemoveExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter expense tracker'), actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(
            Icons.add_box_rounded,
            color: Colors.purple,
          ),
        ),
      ]),
      body: width < 600
          ? Column(
              children: [
                const chart(),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                const chart(),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
