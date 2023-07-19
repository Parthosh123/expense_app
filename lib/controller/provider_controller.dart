import 'package:expense_app/main.dart';
import 'package:expense_app/model/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class ProviderController with ChangeNotifier {
  // Expense expenses = Expense();
  User? user;
  bool loading = false;
  double totalExpense = 0.0;
  List<Expense> expenses = [];
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();

  void getExpense() {
    loading = true;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('expense tracker/${user!.uid}/');
    starCountRef.once().then((event) {
      var value = event.snapshot.child('totalExpense').value.toString();
      totalExpense = totalExpense + double.parse(value);
    });
    starCountRef.child('expense').once().then((event) {
      Expense newExpense = Expense();
      final data = event.snapshot;
      (data.value as Map).forEach((key, value) {
        newExpense = Expense(
          title: value['title'],
          amount: value['amount']?.toDouble(),
          date: value['date'],
          category: value['category'],
          notes: value['notes'],
        );
      });
      expenses.add(newExpense);
      loading = false;
      notifyListeners();
    });
  }

  void addExpense(context) {
    Navigator.pop(context);
    loading = true;
    String title = expenseTitleController.text;
    double amount = double.tryParse(expenseAmountController.text) ?? 0.0;
    DateTime date = DateTime.now();
    String category = "Other"; // Default category
    String notes = "";
    user = auth.currentUser;
    try {
      databaseReference.child("expense tracker").child(user!.uid).child("expense").push().set({
        'title': title,
        'amount': amount,
        'date': date.toString(),
        'category': category,
        'notes': notes,
      }).then((value) {
        DatabaseReference starCountRef = FirebaseDatabase.instance.ref('expense tracker/${user!.uid}/');
        starCountRef.once().then((event) {
          var value = event.snapshot.child('totalExpense').value.toString();
          totalExpense = totalExpense + double.parse(value);
        });
        starCountRef.child('expense').once().then((event) {
          Expense newExpense = Expense();
          final data = event.snapshot;
          (data.value as Map).forEach((key, value) {
            newExpense = Expense(
              title: value['title'],
              amount: value['amount']?.toDouble(),
              date: value['date'],
              category: value['category'],
              notes: value['notes'],
            );
          });
          expenses.add(newExpense);
          expenseAmountController.clear();
          expenseTitleController.clear();
          loading = false;
          notifyListeners();
        });
      });
    } finally {
      loading = false;
    }
  }

// SharedPreferences? localData;
  // initial() async {
  //   localData = await SharedPreferences.getInstance();
  //   notifyListeners();
  // }
  //
  // getPostData(context) async {
  //   loading = true;
  //   post = await getSinglePostData(context);
  //   loading = false;
  //
  //   notifyListeners();
  // }

  //
  // Future<PostModel> getSinglePostData(context) async {
  //   PostModel result;
  //   try {
  //     final response = await http.get(
  //       "https://jsonplaceholder.typicode.com/posts/1",
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final item = json.decode(response.body);
  //       result = PostModel.fromJson(item);
  //     } else {
  //       Toast.show("Data not found", context,
  //           duration: 2, backgroundColor: Colors.redAccent);
  //     }
  //   } catch (e) {
  //     log(e);
  //   }
  //   return result;
  // }
}
