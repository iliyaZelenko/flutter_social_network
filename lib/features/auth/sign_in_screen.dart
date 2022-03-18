import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool _rememberMe = false;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
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
                ),
              ),
              AppTextField(
                  labelText: 'пароль',
                  hideInput: _hidePassword,
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                    child: Icon(
                      _hidePassword ? AppIcons.eye_line : AppIcons.eye_close_line,
                      color: AppColors.white40,
                      size: 26,
                    ),
                  )),
              // Checkbox
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 15),
                child: Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        shape: const CircleBorder(),
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rememberMe = !_rememberMe;
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
                  const RegularAppBtn(text: 'войти'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
