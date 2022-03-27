import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:bolter_flutter/src/bolter_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/app_text_field.dart';
import 'package:rate_club/resources/common_widgets/buttons/regular_app_btn.dart';
import 'package:rate_club/resources/constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPresenter = Provider.of<AuthPresenter>(context);

    return ColoredBox(
      color: AppColors.white100,
      child: SafeArea(
        child: Padding(
          padding: Constants.standardScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Войти',
                style: AppTextStyles.semiBold25.apply(color: AppColors.black100),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: AppTextField(
                  labelText: 'адрес электронной почты',
                  textInputType: TextInputType.emailAddress,
                  initialValue: authPresenter.username,
                  onChanged: (value) {
                    authPresenter.setInput(username: value);
                  },
                ),
              ),
              Observer(
                builder: (_) {
                  return AppTextField(
                    labelText: 'пароль',
                    hideInput: authPresenter.hidePassword,
                    initialValue: authPresenter.password,
                    suffix: InkWell(
                      onTap: () {
                        authPresenter.hidePassword = !authPresenter.hidePassword;
                      },
                      child: Icon(
                        authPresenter.hidePassword ? AppIcons.eye_line : AppIcons.eye_close_line,
                        color: AppColors.white40,
                        size: 26,
                      ),
                    ),
                    onChanged: (value) {
                      authPresenter.setInput(password: value);
                    },
                  );
                },
              ),
              // Checkbox
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 15),
                child: Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Row(
                    children: [
                      Observer(
                        builder: (_) {
                          return Checkbox(
                            shape: const CircleBorder(),
                            value: authPresenter.rememberMe,
                            onChanged: (bool? value) {
                              authPresenter.rememberMe = value!;
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          authPresenter.rememberMe = !authPresenter.rememberMe;
                        },
                        child: Text(
                          'запомнить меня',
                          style: AppTextStyles.regular12.apply(color: AppColors.black80),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Observer(
                    builder: (_) {
                      return RegularAppBtn(
                        text: 'войти',
                        loading: authPresenter.loading,
                        onTap: () {
                          authPresenter.signIn();
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
