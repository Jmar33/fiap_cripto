import 'dart:developer';

import 'package:financy_app/common/models/balances_model.dart';
import 'package:financy_app/services/secure_storage.dart';

import '../common/models/transaction_model.dart';

abstract class TransactionRepository {
    Future<bool> addTransaction(
    TransactionModel transactionModel,
    String userId,
  );
  Future<List<TransactionModel>> getAllTransactions();

  Future<bool> updateTransaction(
    TransactionModel transactionModel,
    String userId
  );

  Future<BalancesModel> getBalances();
}

class TransactionRepositoryImpl implements TransactionRepository {

  static final List<TransactionModel> transactions = [];

  @override
  Future<bool> addTransaction(
    TransactionModel transaction,
    String userId,
  ) async {
    try {
      transaction.id = (transactions.length + 1).toString();
      transactions.add(transaction);
      return true;  
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    await Future.delayed(const Duration(seconds: 2));      
    return transactions;
  }

  @override
  Future<BalancesModel> getBalances() async {
    try {
      
      final incomeTransactions = transactions.where((e) => e.value > 0);
      final outcomeTransactions = transactions.where((e) => e.value < 0);
      
      final totalBalance = transactions.isNotEmpty ? transactions.map((e) => e.value).reduce((value, element) => value = value + element) : 0;
      final totalIncome = incomeTransactions.isNotEmpty ? incomeTransactions.map((e) => e.value).reduce((value, element) => value = value + element) : 0;
      final totalOutcome = outcomeTransactions.isNotEmpty ? outcomeTransactions.map((e) => e.value).reduce((value, element) => value = value + element) : 0;
      
      final response = {
        "totalBalance": {
          "aggregate": {
            "sum": {
              "value": totalBalance
            }
          }
        },
        "totalIncome": {
          "aggregate": {
            "sum": {
              "value": totalIncome
            }
          }
        },
        "totalOutcome": {
          "aggregate": {
            "sum": {
              "value": totalOutcome
            }
          }
        },      
      }; 
      
          

     final balances = BalancesModel.fromMap(response);

      return balances;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateTransaction(
    TransactionModel transaction,
    String id
  ) async {
    try {

      if(id != null && id != ""){
        transactions[transactions.indexWhere((transactionInList) => transactionInList.id == id)] = transaction;
        return true;
      }

      return false;

      
      
    } catch (e) {
      rethrow;
    }
  }
}
