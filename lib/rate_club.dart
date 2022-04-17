library rate_club;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rate_club/resources/global_events/events/AbstractGlobalEvent.dart';

export 'package:app_http_client/app_http_client.dart';
export 'package:collection/collection.dart';
export 'package:equatable/equatable.dart';
export 'package:rate_club/features/feature_interface.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:worker_manager/src/cancelable/cancelable.dart';

typedef MainNavigatorKeyType = GlobalKey<NavigatorState>;
typedef GlobalEventsStreamType = StreamController<AbstractGlobalEvent>;
