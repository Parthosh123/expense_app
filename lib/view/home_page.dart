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
}
