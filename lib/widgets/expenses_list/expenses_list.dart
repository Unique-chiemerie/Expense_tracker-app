import 'package:flutter/material.dart';
import 'package:test_proj/main.dart';
import 'package:test_proj/model/Expense.dart';
import 'package:test_proj/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              ),
              key: ValueKey(expenses[index]),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            ));
  }
}
