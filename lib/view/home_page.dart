import 'package:expense_app/model/expense_model.dart';
import 'package:expense_app/model/income_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense> expenses = [];
  List<Income> income = [];

  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController incomeSourceController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();

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

  void addIncome() {
    String source = incomeSourceController.text;
    double amount = double.tryParse(incomeAmountController.text) ?? 0.0;
    DateTime date = DateTime.now();

    Income newIncome = Income(
      source: source,
      amount: amount,
      date: date,
    );

    setState(() {
      income.add(newIncome);
    });

    incomeSourceController.clear();
    incomeAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // View expenses
            SizedBox(height: 20),
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
                    subtitle: Text("${expense.amount}"),
                    trailing: Text(expense.date.toString()),
                  );
                },
              ),
            ),

            // Income input form
            TextField(
              controller: incomeSourceController,
              decoration: InputDecoration(labelText: "Income Source"),
            ),
            TextField(
              controller: incomeAmountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Income Amount"),
            ),
            ElevatedButton(
              onPressed: addIncome,
              child: Text("Add Income"),
            ),

            // View income
            SizedBox(height: 20),
            Text(
              "Income",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: income.length,
                itemBuilder: (context, index) {
                  var incomeItem = income[index];
                  return ListTile(
                    title: Text(incomeItem.source!),
                    subtitle: Text("${incomeItem.amount}"),
                    trailing: Text(incomeItem.date.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  expenseBottomSheet() {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.greenAccent,
      backgroundColor: Colors.yellow,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
