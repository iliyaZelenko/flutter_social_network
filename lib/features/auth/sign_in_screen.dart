import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:bolter_flutter/src/bolter_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/auth/auth_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/app_text_field.dart';
import 'package:rate_club/resources/common_widgets/buttons/regular_app_btn.dart';
import 'package:rate_club/resources/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final presenter = context.presenter<AuthPresenter>();

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
                  initialValue: presenter.username,
                  onChanged: (value) {
                    presenter.username = value;
                  },
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: presenter.hidePassword,
                builder: (_, value, __) {
                  return AppTextField(
                    labelText: 'пароль',
                    hideInput: value,
                    initialValue: presenter.password,
                    suffix: InkWell(
                      onTap: () {
                        presenter.hidePassword.value = !presenter.hidePassword.value;
                      },
                      child: Icon(
                        value ? AppIcons.eye_line : AppIcons.eye_close_line,
                        color: AppColors.white40,
                        size: 26,
                      ),
                    ),
                    onChanged: (value) {
                      presenter.password = value;
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
                      ValueListenableBuilder<bool>(
                        valueListenable: presenter.rememberMe,
                        builder: (_, value, __) {
                          return Checkbox(
                            shape: const CircleBorder(),
                            value: value,
                            onChanged: (bool? value) {
                              setState(() {
                                presenter.rememberMe.value = value!;
                              });
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            presenter.rememberMe.value = !presenter.rememberMe.value;
                          });
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
                  ValueStreamBuilder<bool>(
                    valueStream: presenter.loadingStream,
                    builder: (context, loading) {
                      return RegularAppBtn(
                        text: 'войти',
                        loading: loading,
                        onTap: () {
                          presenter.signIn(
                            username: presenter.username,
                            password: presenter.password,
                          );
                        },
                      );
                    }
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
