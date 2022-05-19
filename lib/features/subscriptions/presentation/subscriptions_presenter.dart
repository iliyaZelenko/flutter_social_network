import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/payments/money_formatter/money_formatter_interface.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';
import 'package:rate_club/features/subscriptions/domain/use_cases/subscribe_use_case.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/assets.dart';
import 'package:rate_club/resources/common_widgets/app_inline_loader.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_big.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_regular.dart';
import 'package:rate_club/resources/common_widgets/dialogs.dart';
import 'package:rate_club/resources/helpers.dart';

part 'subscriptions_presenter.g.dart';

class SubscriptionsPresenter = SubscriptionsPresenterBase with _$SubscriptionsPresenter;

abstract class SubscriptionsPresenterBase with Store {
  final SubscribeUseCase _subscribeUseCase;

  SubscriptionsPresenterBase({
    required SubscribeUseCase subscribeUseCase,
  }) : _subscribeUseCase = subscribeUseCase;

  @readonly
  bool _loadingSubscribeInDialog = false;

  @action
  Future<bool?> subscribe(BuildContext context, Iterable<SubscriptionPlanEntity> plans) async {
    final plansInfo = getPlansInfo(plans);
    final moneyFormatter = Provider.of<MoneyFormatterInterface>(context, listen: false);
    final mainNavigatorKey = Provider.of<MainNavigatorKeyType>(context, listen: false);

    // TODO Ilya: move widget to a separated file
    return showAppDialog<bool>(
      context: context,
      child: Observer(
        builder: (_) {
          return Column(
            children: [
              SvgPicture.asset(Assets.crystalPremium),
              const SizedBox(height: 10),
              Text(
                'get premium content',
                style: AppTextStyles.regular18.apply(color: AppColors.black80),
              ),
              const SizedBox(height: 9),
              Text(
                '${moneyFormatter.format(plansInfo.premiumPlan.cost)} / month',
                style: AppTextStyles.regular13.apply(color: AppColors.black60),
              ),
              const SizedBox(height: 30),
              if (_loadingSubscribeInDialog)
                const Center(
                  child: AppInlineLoader(),
                )
              else ...[
                if (!plansInfo.subscriptionFreeActive!) ...[
                  AppBtnRegular(
                    text: 'or subscribe for free plan',
                    color: AppColors.black20,
                    textColor: AppColors.white100,
                    useMinPadding: true,
                    onTap: () async {
                      _loadingSubscribeInDialog = true;
                      await _subscribeUseCase.execute(plansInfo.freePlan.id);
                      _loadingSubscribeInDialog = false;

                      mainNavigatorKey.currentState!.pop(true);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
                AppBtnBig(
                  text: 'subscribe',
                  color: AppColors.purple100,
                  textColor: AppColors.white80,
                  onTap: () async {
                    _loadingSubscribeInDialog = true;
                    await _subscribeUseCase.execute(plansInfo.premiumPlan.id);
                    _loadingSubscribeInDialog = false;

                    mainNavigatorKey.currentState!.pop(true);
                  },
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
