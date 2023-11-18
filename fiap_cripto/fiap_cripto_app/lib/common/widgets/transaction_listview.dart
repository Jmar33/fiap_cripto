import 'package:flutter/material.dart';

import '../../features/home/home_controller.dart';
import '../../features/home/widgets/balance_card/balance_card_widget_controller.dart';
import '../../locator.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
// import '../extensions/date_formatter.dart';
import '../models/transaction_model.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({
    super.key,
    required this.transactionList,
    this.itemCount,
  });

  final List<TransactionModel> transactionList;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount ?? transactionList.length,
      itemBuilder: (context, index) {
        final item = transactionList[index];

        final color =
            item.value.isNegative ? AppColors.outcome : AppColors.income;
        final value = "\$${item.value.toStringAsFixed(2)}";
        return ListTile(
          onTap: () async {
            final result = await Navigator.pushNamed(
              context,
              '/transaction',
              arguments: item,
            );
            if (result != null) {
              locator.get<HomeController>().getAllTransactions();
              locator.get<BalanceCardWidgetController>().getBalances();
            }
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          leading: Container(
            decoration: const BoxDecoration(
              color: AppColors.antiFlashWhite,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: const EdgeInsets.all(8.0),
            child:  Image.asset(
                  _getImagePath(item.coin),
                  width: 24.0, 
                  height: 24.0,
            )
          ),
          title: Text(
            item.coin,
            style: AppTextStyles.mediumText16w500,
          ),
          subtitle: Text(
            DateTime.fromMillisecondsSinceEpoch(item.date).toString(),
            style: AppTextStyles.smallText13,
          ),
          trailing: Text(
            value,
            style: AppTextStyles.mediumText18.apply(color: color),
          ),
        );
      },
    );
  }

  String _getImagePath(String coin) {
    switch (coin) {
      case 'BITICOIN':
        return 'assets/images/bitcoin.png'; 
      case 'ETHEREUM':
        return 'assets/images/ethereum.png';
      case 'POLYGON':
        return 'assets/images/polygon.png';
      default:
        return 'assets/images/bitcoin.png'; 
    }
  }
}
