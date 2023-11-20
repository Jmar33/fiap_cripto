import 'package:financy_app/common/widgets/app_header.dart';
import 'package:financy_app/common/widgets/transaction_listview.dart';
import 'package:financy_app/features/home/widgets/balance_card/balance_card_widget.dart';
import 'package:financy_app/features/home/widgets/balance_card/balance_card_widget_controller.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/extensions/sizes.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../locator.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = locator.get<HomeController>();
  final balanceController = locator.get<BalanceCardWidgetController>();

  @override
  void initState() {
    super.initState();
    homeController.getAllTransactions();
    balanceController.getBalances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          BalanceCard(controller: balanceController),
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const Text(
                        'Histórico de transações',
                        style: AppTextStyles.mediumText18,
                      ),
                      GestureDetector(
                        onTap: (){
                          homeController.pageController.jumpToPage(2);
                        },
                        child:  const Text(
                          'Ver tudo',
                          style: AppTextStyles.inputLabelText,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: homeController,
                    builder: (context, _) {
                      if (homeController.state is HomeStateLoading) {
                        return const CustomCircularProgressIndicator(
                          color: AppColors.pink,
                        );
                      }
                      if (homeController.state is HomeStateError) {
                        return const Center(
                          child: Text('Ocorreu um erro'),
                        );
                      }
                      if (homeController.state is HomeStateSuccess &&  homeController.transactions.isNotEmpty) {
                        return TransactionListView(
                          transactionList: homeController.transactions,
                          itemCount: homeController.transactions.length,
                        );
                      }
                      return const Center(
                          child: Text('Não há transações nesse perído'),
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
