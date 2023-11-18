import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
// import '../../common/extensions/date_formatter.dart';
import '../../common/extensions/sizes.dart';
import '../../common/models/transaction_model.dart';
import '../../common/utils/money_mask_controller.dart';
import '../../common/widgets/app_header.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/custom_text_form_field.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';
import 'transaction_controller.dart';
import 'transaction_state.dart';

class TransactionPage extends StatefulWidget {
  final TransactionModel? transaction;
  const TransactionPage({
    super.key,
    this.transaction,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  final _transactionController = locator.get<TransactionController>();

  final _formKey = GlobalKey<FormState>();

  final _coins = ['BITCOIN', 'ETHEREUM', 'POLYGON'];
  DateTime? _newDate;
  bool value = false;

  final _quantityController = TextEditingController();
  final _coinController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = MoneyMaskedTextController(
    prefix: '\$',
  );

  late final TabController _tabController;

  int get _initialIndex {
    if (widget.transaction != null && widget.transaction!.price.isNegative) {
      return 1;
    }

    return 0;
  }

  String get _date {
    if (widget.transaction?.date != null) {
      return DateTime.fromMillisecondsSinceEpoch(widget.transaction!.date)
          .toString();
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _priceController.updateValue(widget.transaction?.price ?? 0);
    value = widget.transaction?.status ?? false;
    _quantityController.text = widget.transaction?.quantity.toString() ?? '0';
    _coinController.text = widget.transaction?.coin ?? '';
    _newDate =
        DateTime.fromMillisecondsSinceEpoch(widget.transaction?.date ?? 0);
    _dateController.text = widget.transaction?.date != null
        ? DateTime.fromMillisecondsSinceEpoch(widget.transaction!.date).toString()
        : '';
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: _initialIndex,
    );

    _transactionController.addListener(() {
      if (_transactionController.state is TransactionStateLoading) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_transactionController.state is TransactionStateSuccess) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _coinController.dispose();
    _dateController.dispose();
    _transactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppHeader(
            title: widget.transaction != null
                ? 'Editar Transação'
                : 'Adicionar Transação',
          ),
          Positioned(
            top: 164.h,
            left: 28.w,
            right: 28.w,
            bottom: 16.h,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TabBar(
                            labelPadding: EdgeInsets.zero,
                            controller: _tabController,
                            onTap: (_) {
                              if (_tabController.indexIsChanging) {
                                setState(() {});
                              }
                              // if (_tabController.indexIsChanging &&
                              //     _categoryController.text.isNotEmpty) {
                              //   _categoryController.clear();
                              // }
                            },
                            tabs: [
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabController.index == 0
                                        ? AppColors.iceWhite
                                        : AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Compra',
                                    style: AppTextStyles.mediumText16w500
                                        .apply(color: AppColors.darkGrey),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabController.index == 1
                                        ? AppColors.iceWhite
                                        : AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Venda',
                                    style: AppTextStyles.mediumText16w500
                                        .apply(color: AppColors.darkGrey),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _coinController,
                        readOnly: true,
                        labelText: "Moeda",
                        hintText: "Selecione uma moeda",
                        validator: (value) {
                          if (_coinController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: (_coins)
                                .map(
                                  (e) => TextButton(
                                    onPressed: () {
                                      _coinController.text = e;
                                      Navigator.pop(context);
                                    },
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        labelText: 'Quantidade',
                        hintText: 'Digite a quantide comprada',
                        validator: (value) {
                          if (_quantityController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        labelText: "Preço",
                        hintText: "Digite a cotação na data da compra",
                        suffixIcon: StatefulBuilder(
                          builder: (context, setState) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  value = !value;
                                });
                              },
                              icon: AnimatedContainer(
                                transform: value
                                    ? Matrix4.rotationX(math.pi * 2)
                                    : Matrix4.rotationX(math.pi),
                                transformAlignment: Alignment.center,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(Icons.thumb_up_alt_rounded),
                              ),
                            );
                          },
                        ),
                      ),


                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _dateController,
                        readOnly: true,
                        labelText: "Date",
                        hintText: "Select a date",
                        validator: (value) {
                          if (_dateController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                        onTap: () async {
                          _newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2030),
                          );

                          _newDate = _newDate != null
                              ? DateTime.now().copyWith(
                                  day: _newDate?.day,
                                  month: _newDate?.month,
                                  year: _newDate?.year,
                                )
                              : null;

                          _dateController.text =
                              _newDate != null ? _newDate!.toString() : _date;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: PrimaryButton(
                          text: widget.transaction != null ? 'Salvar' : 'Adicionar',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              final newValue = double.parse(_priceController
                                  .text
                                  .replaceAll('\$', '')
                                  .replaceAll('.', '')
                                  .replaceAll(',', '.'));
                              final newTransaction = TransactionModel(
                                coin: _coinController.text,
                                quantity: double.parse(_quantityController.text),
                                price: _tabController.index == 1
                                    ? newValue * -1
                                    : newValue,
                                value: double.parse(_quantityController.text) * (_tabController.index == 1
                                    ? newValue * -1
                                    : newValue),
                                date: _newDate != null
                                    ? _newDate!.millisecondsSinceEpoch
                                    : DateTime.now().millisecondsSinceEpoch,
                                status: value,
                                
                              );
                              if (widget.transaction == newTransaction) {
                                Navigator.pop(context);
                                return;
                              }
                              if (widget.transaction != null) {
                                await _transactionController
                                    .updateTransaction(newTransaction);
                                if (mounted) {
                                  Navigator.pop(context, true);
                                }
                              } else {
                                await _transactionController.addTransaction(
                                  newTransaction,
                                );
                                if (mounted) {
                                  Navigator.pop(context, true);
                                }
                              }
                            } else {
                              log('invalid');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
