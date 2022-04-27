import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/assets.dart';
import 'package:rate_club/resources/common_widgets/app_text_field.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_regular.dart';
import 'package:rate_club/resources/constants.dart';

import 'auth_flow_presenter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPresenter = Provider.of<AuthFlowPresenter>(context);

    return ColoredBox(
      color: AppColors.white100,
      child: SafeArea(
        child: Padding(
          padding: Constants.standardScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Center(child: Image.asset(Assets.logoText)),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Log in',
                  style: AppTextStyles.semiBold32.apply(color: AppColors.black100),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: AppTextField(
                  labelText: 'email',
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
                    labelText: 'password',
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
                            value: authPresenter.rememberMe,
                            fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) return AppColors.transparent;
                              return null;
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(color: AppColors.white20),
                            ),
                            checkColor: AppColors.blue80,
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
                          'remember me',
                          style: AppTextStylesOld.regular12.apply(color: AppColors.black80),
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
                      return Expanded(
                        child: AppBtnRegular(
                          text: 'Log in',
                          loading: authPresenter.loading,
                          onTap: () {
                            authPresenter.signIn();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) {
                  return authPresenter.error == null
                      ? const SizedBox.shrink()
                      : Text(
                          authPresenter.error!,
                          style: AppTextStylesOld.regular15.apply(color: AppColors.red80),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
