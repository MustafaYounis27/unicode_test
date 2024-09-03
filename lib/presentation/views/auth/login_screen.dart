import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/core/router.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/generated/locale_keys.g.dart';
import 'package:unicode_test/main.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_body.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_button.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_text_form_field.dart';
import 'package:unicode_test/presentation/shared_widgets/spacing.dart';
import 'package:unicode_test/presentation/views/auth/auth_cubit.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthCubit _cubit = AuthCubit(injector());

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: SizedBox(
          width: 1.sw,
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 8),
            child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is UserLoginSuccessfuly) {
                  unawaited(Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false));
                  return;
                }
              },
              builder: (context, state) {
                return UnifiedButton(
                  disabled: !_cubit.loginButtonEnabled,
                  loading: state is Loading,
                  onPressed: _cubit.login,
                  title: LocaleKeys.login.tr(),
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: UnifiedBody(
          actions: [
            IconButton(
              onPressed: () async {
                if (context.locale.isEnglish) {
                  await context.setLocale(const Locale('ar', 'AR'));
                } else {
                  await context.setLocale(const Locale('en', 'EN'));
                }

                reRenderWholeAppNotifier.value = DateTime.now();
              },
              icon: const Icon(Icons.language_rounded, color: ColorsPalletes.secondry500),
            ),
          ],
          title: LocaleKeys.login.tr(),
          child: Form(
            key: _cubit.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () => setState(() {}),
            child: ListView(
              padding: REdgeInsets.all(20),
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    LocaleKeys.fillData.tr(),
                    style: TextStyles.semiBold_12.copyWith(color: ColorsPalletes.mainColor),
                  ),
                ),
                verticalSpace(0.04.sh),
                UnifiedTextFormField(
                  title: LocaleKeys.email.tr(),
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintText: LocaleKeys.emailAddress.tr(),
                  controller: _cubit.emailController,
                  focusNode: _cubit.emailFocusNode,
                ),
                verticalSpace(0.02.sh),
                UnifiedTextFormField(
                  title: LocaleKeys.password.tr(),
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  hintText: LocaleKeys.password.tr(),
                  controller: _cubit.passwordController,
                  focusNode: _cubit.passwordFocusNode,
                  suffixIconColor: ColorsPalletes.secondry600,
                ),
                verticalSpace(0.03.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.firstTime.tr(), style: TextStyles.regular_12),
                    InkWell(
                      onTap: () {
                        unawaited(Navigator.pushNamed(context, Routes.register));
                      },
                      child: Padding(
                        padding: REdgeInsets.all(6),
                        child: Text(LocaleKeys.register.tr(), style: TextStyles.semiBold_12.copyWith(color: ColorsPalletes.mainColor)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
