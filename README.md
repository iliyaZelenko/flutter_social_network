# Flutter social network

## Features

Feed with posts, post page, comments, profiles, likes, auth.

## Stack

MobX, Dio, `json_serializable`, `provider`, `flutter_simple_dependency_injection`

## Architecture

Features-based, DDD, Provider, DI, UI logic separated to presenters, domain logic in `domain` layer.

## Code style

- 120 line length
- `dartfmt` before merge request
- snake_case for all files

## Icons

[Docs](./list_icons.md)

Icons generated by script: [icons_generator.py](./scripts/icons_generator.py)

Run using: 

```commandline
python icons_generator.py
```

Handles [assets/icons/](./assets/icons/) folder.

# Environment variables

You can setup it [here](https://github.com/iliyaZelenko/flutter_social_network/blob/main/lib/features/env/env_feature.dart#L19).

## Info

Some features are created only in their start state.
