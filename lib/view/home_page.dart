import 'package:expense_app/model/expense_model.dart';
import 'package:expense_app/model/income_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // View expenses
              SizedBox(height: 20),
              Text(
                "Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  itemCount: expenses.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var expense = expenses[index];
                    return Card(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        height: 50.0,
                        width: 150.0,
                        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(expense.title!),
                            Text("${expense.amount}"),
                            Text(DateFormat("dd MMMM, yyyy").format(expense.date!)),
                          ],
                        ),
                      ),
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
      ),
    );
  }
}
