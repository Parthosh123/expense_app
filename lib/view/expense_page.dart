import 'package:expense_app/common_widgets/TextField.dart';
import 'package:expense_app/common_widgets/button.dart';
import 'package:expense_app/controller/provider_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                            "₹ " +
                                NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2)
                                    .format(provider.totalExpense),
                            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                          ))),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Expenses",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              expenseBottomSheet();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.black,
                                  size: 15.0,
                                ),
                                Text(
                                  " add",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 8,
                        child: ListView.builder(
                          itemCount: provider.expenses.length,
                          itemBuilder: (context, index) {
                            var expense = provider.expenses[index];
                            return Card(
                              elevation: 1.5,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                title: Text(
                                  expense.title!.capitalize(),
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  "₹ " +
                                      NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2).format(expense.amount),
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  DateFormat("dd MMM , yyyy").format(DateTime.parse(expense.date!)),
                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                ),
                              ),
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

  expenseBottomSheet() {
    final provider = Provider.of<ProviderController>(context, listen: false);
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
          height: MediaQuery.of(context).size.height / 2.5 + MediaQuery.of(context).viewInsets.bottom,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFieldWidget(
                  controller: provider.expenseTitleController,
                  enterHint: "Expense Title",
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFieldWidget(
                  inputType: TextInputType.number,
                  controller: provider.expenseAmountController,
                  enterHint: "Expense Amount",
                ),
                SizedBox(
                  height: 25.0,
                ),
                OutlinedButtonWidget(
                  color: Colors.deepPurple,
                  minHeight: 50.0,
                  minWidth: MediaQuery.of(context).size.width,
                  press: () {
                    provider.addExpense(context);
                  },
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
