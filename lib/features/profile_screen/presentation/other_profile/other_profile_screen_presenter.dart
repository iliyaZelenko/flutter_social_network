import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_profile_feed_use_case.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/features/subscriptions/domain/use_cases/cancel_subscription_use_case.dart';
import 'package:rate_club/features/subscriptions/domain/use_cases/get_subscriptions_by_profile_use_case.dart';
import 'package:rate_club/features/subscriptions/presentation/subscriptions_presenter.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/common_widgets/app_inline_loader.dart';
import 'package:rate_club/resources/common_widgets/cupertino_ink_well.dart';
import 'package:rate_club/resources/common_widgets/dialogs.dart';
import 'package:rate_club/resources/icons/icon_profile_remove.dart';

part 'other_profile_screen_presenter.g.dart';

class OtherProfileScreenPresenter = OtherProfileScreenPresenterBase with _$OtherProfileScreenPresenter;

abstract class OtherProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final String _nickname;
  final GetProfileScreenUseCase _getProfileScreenUseCase;
  final GetProfileFeedUseCase _getProfileFeedUseCase;
  final GetSubscriptionsByProfileUseCase _getSubscriptionsByProfileUseCase;
  final CancelSubscriptionUseCase _cancelSubscriptionUseCase;

  OtherProfileScreenPresenterBase({
    required String nickname,
    required GetProfileScreenUseCase getProfileScreenUseCase,
    required GetProfileFeedUseCase getProfileFeedUseCase,
    required GetSubscriptionsByProfileUseCase getSubscriptionsByProfileUseCase,
    required CancelSubscriptionUseCase cancelSubscriptionUseCase,
  })  : _nickname = nickname,
        _getProfileScreenUseCase = getProfileScreenUseCase,
        _getProfileFeedUseCase = getProfileFeedUseCase,
        _getSubscriptionsByProfileUseCase = getSubscriptionsByProfileUseCase,
        _cancelSubscriptionUseCase = cancelSubscriptionUseCase;

  @readonly
  ProfileScreenEntity? _fetchedProfile;

  @readonly
  FeedResponse? _feedResponse;

  @override
  @computed
  ProfileScreenEntity? get profile => _fetchedProfile;

  // TODO Ilya: не работает refresh (ObservableList?)
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
    final subscriptionsPresenter = Provider.of<SubscriptionsPresenter>(context, listen: false);

    _loadingSubscribe = true;
    final plans = await _getSubscriptionsByProfileUseCase.execute(profile!.id);
    _loadingSubscribe = false;

    // If subscribed
    if (await subscriptionsPresenter.subscribe(context, plans) == true) {
      await refresh();
    }
  }

  @action
  Future<void> openMenu(BuildContext context) async {
    final mainNavigatorKey = Provider.of<MainNavigatorKeyType>(context, listen: false);

    await showAppDialog(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unsubscribe
          CupertinoInkWell(
            onPressed: () async {
              final subscriptionCoid = profile!.subscriptionPremiumActiveCoid ?? profile!.subscriptionFreeActiveCoid!;

              _loadingSubscribeInDialog = true;
              await _cancelSubscriptionUseCase.execute(subscriptionCoid);
              await refresh();
              _loadingSubscribeInDialog = false;

              mainNavigatorKey.currentState!.pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Observer(
                builder: (_) {
                  final subType = profile!.subscriptionPremiumActive ? 'premium' : '';

                  return _loadingSubscribeInDialog
                      ? const Center(
                          child: AppInlineLoader(),
                        )
                      : Row(
                          children: [
                            const IconProfileRemove(),
                            const SizedBox(width: 10),
                            Text('unsubscribe $subType'),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
