import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/core/router.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_body.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_button.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_text_form_field.dart';
import 'package:unicode_test/presentation/shared_widgets/spacing.dart';
import 'package:unicode_test/presentation/views/auth/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              listener: (context, state) async {
                if (state is UserRegisterSuccessfuly) {
                  unawaited(_cubit.completeUserData(state.UID));
                  return;
                }

                if (state is DataCompletedSuccessfuly) {
                  unawaited(Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false));
                  return;
                }
              },
              builder: (context, state) {
                return UnifiedButton(
                  disabled: !_cubit.registerButtonEnabled,
                  loading: state is Loading,
                  onPressed: _cubit.register,
                  title: 'Register',
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: UnifiedBody(
          title: 'Register',
          child: Form(
            key: _cubit.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () => setState(() {}),
            child: ListView(
              padding: REdgeInsets.all(16),
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Please, fill all required fields to be a member of our family',
                    style: TextStyles.semiBold_12.copyWith(color: ColorsPalletes.mainColor),
                  ),
                ),
                verticalSpace(0.04.sh),
                UnifiedTextFormField(
                  title: 'Full name',
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  hintText: 'full name',
                  controller: _cubit.nameController,
                  focusNode: _cubit.nameFocusNode,
                ),
                verticalSpace(0.02.sh),
                UnifiedTextFormField(
                  title: 'Email',
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintText: 'email address',
                  controller: _cubit.emailController,
                  focusNode: _cubit.emailFocusNode,
                ),
                verticalSpace(0.02.sh),
                UnifiedTextFormField(
                  title: 'Password',
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  hintText: 'password',
                  controller: _cubit.passwordController,
                  focusNode: _cubit.passwordFocusNode,
                  suffixIconColor: ColorsPalletes.secondry600,
                ),
                verticalSpace(0.1.sh),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
