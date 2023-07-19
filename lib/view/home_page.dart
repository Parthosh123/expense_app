import 'package:expense_app/controller/provider_controller.dart';
import 'package:expense_app/model/income_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Income> income = [];

  // @override
  // void initState() {
  //   final getData = Provider.of<ProviderController>(context, listen: false);
  //   getData.getExpense();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, provider, child) => Scaffold(
        body: SafeArea(
          child: provider.loading
              ? Center(child: CircularProgressIndicator())
              : Padding(
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
                        height: 130.0,
                        child: ListView.builder(
                          itemCount: provider.expenses.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var expense = provider.expenses[index];
                            return Card(
                              elevation: 1.5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                // height: 40.0,
                                width: 150.0,
                                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "₹ " +
                                              NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2)
                                                  .format(provider.totalExpense),
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                        child: Text(expense.title!.capitalize(),
                                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))),
                                    Expanded(
                                      child: Text(
                                        DateFormat("dd MMM , yyyy").format(DateTime.parse(expense.date!)),
                                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
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
      ),
    );
  }
}
