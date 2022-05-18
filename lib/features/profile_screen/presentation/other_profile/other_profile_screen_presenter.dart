import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injector/injector.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_profile_feed_use_case.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/payments/money_formatter/money_formatter_interface.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/features/subscriptions/domain/use_cases/cancel_subscription_use_case.dart';
import 'package:rate_club/features/subscriptions/domain/use_cases/get_subscriptions_by_profile_use_case.dart';
import 'package:rate_club/features/subscriptions/domain/use_cases/subscribe_use_case.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/assets.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_big.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_regular.dart';
import 'package:rate_club/resources/common_widgets/cupertino_ink_well.dart';
import 'package:rate_club/resources/common_widgets/dialogs.dart';
import 'package:rate_club/resources/helpers.dart';
import 'package:rate_club/resources/icons/icon_profile_remove.dart';

part 'other_profile_screen_presenter.g.dart';

class OtherProfileScreenPresenter = OtherProfileScreenPresenterBase with _$OtherProfileScreenPresenter;

abstract class OtherProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final String _nickname;
  final GetProfileScreenUseCase _getProfileScreenUseCase;
  final GetProfileFeedUseCase _getProfileFeedUseCase;
  final GetSubscriptionsByProfileUseCase _getSubscriptionsByProfileUseCase;
  final SubscribeUseCase _subscribeUseCase;
  final CancelSubscriptionUseCase _cancelSubscriptionUseCase;

  OtherProfileScreenPresenterBase({
    required String nickname,
    required GetProfileScreenUseCase getProfileScreenUseCase,
    required GetProfileFeedUseCase getProfileFeedUseCase,
    required GetSubscriptionsByProfileUseCase getSubscriptionsByProfileUseCase,
    required SubscribeUseCase subscribeUseCase,
    required CancelSubscriptionUseCase cancelSubscriptionUseCase,
  })  : _nickname = nickname,
        _getProfileScreenUseCase = getProfileScreenUseCase,
        _getProfileFeedUseCase = getProfileFeedUseCase,
        _getSubscriptionsByProfileUseCase = getSubscriptionsByProfileUseCase,
        _subscribeUseCase = subscribeUseCase,
        _cancelSubscriptionUseCase = cancelSubscriptionUseCase;

  @readonly
  ProfileScreenEntity? _fetchedProfile;

  @readonly
  FeedResponse? _feedResponse;

  // TODO Ilya: why don't refresh? ObservableStream/ObservableFuture
  @override
  @computed
  ProfileScreenEntity? get profile => _fetchedProfile;

  @override
  @computed
  List<PostEntity>? get posts => _feedResponse?.results;

  @override
  @computed
  int? get postsCount => _feedResponse?.count;

  @readonly
  bool _loading = false;

  @override
  @observable
  int currentTab = 0;

  @readonly
  bool _loadingSubscribe = false;

  @readonly
  bool _loadingSubscribeInDialog = false;

  @override
  @action
  Future<void> fetch() async {
    _loading = true;
    _fetchedProfile = await _getProfileScreenUseCase.execute(_nickname);
    _loading = false;
  }

  @override
  @action
  Future<void> fetchFeed() async {
    _feedResponse = await _getProfileFeedUseCase.execute(nickname: _nickname);
  }

  @override
  @action
  Future<void> refresh() async {
    await Future.wait([
      _getProfileScreenUseCase.execute(_fetchedProfile!.nickname).then(
            (value) => _fetchedProfile = value,
          ),
      fetchFeed(),
    ]);
  }

  @action
  Future<void> subscribe(BuildContext context) async {
    _loadingSubscribe = true;
    final plans = await _getSubscriptionsByProfileUseCase.execute(profile!.id);
    _loadingSubscribe = false;

    final plansInfo = getPlansInfo(plans);
    final moneyFormatter = Provider.of<MoneyFormatterInterface>(context, listen: false);
    final injector = Provider.of<InjectorInterface>(context, listen: false);
    final mainNavigatorKey = injector.get<MainNavigatorKeyType>();

    // TODO Ilya: move widget to a separated file
    await showAppDialog(
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
                  child: CircularProgressIndicator(color: AppColors.blue60),
                )
              else ...[
                if (!profile!.subscriptionFreeActive) ...[
                  AppBtnRegular(
                    text: 'or subscribe for free plan',
                    color: AppColors.black20,
                    textColor: AppColors.white100,
                    useMinPadding: true,
                    onTap: () async {
                      _loadingSubscribeInDialog = true;
                      await _subscribeUseCase.execute(plansInfo.freePlan.id);
                      await refresh();
                      _loadingSubscribeInDialog = false;

                      mainNavigatorKey.currentState!.pop();
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
                    await refresh();
                    _loadingSubscribeInDialog = false;

                    mainNavigatorKey.currentState!.pop();
                  },
                ),
              ]
            ],
          );
        },
      ),
    );
  }

  @action
  Future<void> openMenu(BuildContext context) async {
    final injector = Provider.of<InjectorInterface>(context, listen: false);
    final mainNavigatorKey = injector.get<MainNavigatorKeyType>();

    await showAppDialog(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoInkWell(
            onPressed: () async {
              final subscriptionCoid = profile!.subscriptionPremiumActiveCoid ?? profile!.subscriptionFreeActiveCoid!;

              await _cancelSubscriptionUseCase.execute(subscriptionCoid);
              await refresh();

              mainNavigatorKey.currentState!.pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: const [
                  IconProfileRemove(),
                  SizedBox(width: 10),
                  Text('unsubscribe'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
