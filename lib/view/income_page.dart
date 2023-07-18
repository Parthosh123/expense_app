import 'package:expense_app/model/income_model.dart';
import 'package:flutter/material.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  List<Income> income = [];
  TextEditingController incomeSourceController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();

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
          children: [
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
}
