// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:financy_app/common/constants/app_colors.dart';
import 'package:financy_app/common/constants/app_text_styles.dart';
import 'package:financy_app/common/constants/routes.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/multi_text_button.dart';
import '../../common/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Column(
        children: [
          const SizedBox(height: 48.0),
          Expanded(
            child: Image.asset(
              'assets/images/onboarding_image.png',
            ),
          ),
          Text(
            'Suas Criptos',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText16w600.copyWith(
              color: AppColors.pinkOne,
            ),
          ),
          Text(
            'Na Palma Da Mão',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText16w600.copyWith(
              color: AppColors.pinkOne,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Iniciar',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.signUp,
                );
              },
            ),
          ),
          MultiTextButton(
            onPressed: () => Navigator.pushNamed(context, NamedRoute.signIn),
            children: [
              Text(
                'Já possui uma conta',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Entrar ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.pinkOne,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
