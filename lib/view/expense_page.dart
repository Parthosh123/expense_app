import 'package:expense_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Expense> expenses = [];
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();

  void addExpense() {
    String title = expenseTitleController.text;
    double amount = double.tryParse(expenseAmountController.text) ?? 0.0;
    DateTime date = DateTime.now();
    String category = "Other"; // Default category
    String notes = "";

    Expense newExpense = Expense(
      title: title,
      amount: amount,
      date: date,
      category: category,
      notes: notes,
    );

    setState(() {
      expenses.add(newExpense);
    });
    expenseTitleController.clear();
    expenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  expenseBottomSheet();
                },
                child: Text("Add Income"),
              ),
              // View income
              SizedBox(height: 20), SizedBox(height: 20),
              Text(
                "Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    var expense = expenses[index];
                    return ListTile(
                      title: Text(expense.title!),
                      trailing: Text("${expense.amount}"),
                      subtitle: Text(DateFormat("dd MMMM, yyyy").format(expense.date!)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  expenseBottomSheet() {
    return showModalBottomSheet(
      enableDrag: false,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3.0 + MediaQuery.of(context).viewInsets.bottom,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: expenseTitleController,
                  decoration: InputDecoration(labelText: "Expense Title"),
                ),
                TextField(
                  controller: expenseAmountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: "Expense Amount"),
                ),
                ElevatedButton(
                  onPressed: addExpense,
                  child: Text("Add Expense"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
